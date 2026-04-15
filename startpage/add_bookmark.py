#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
快速添加书签脚本
用于自动下载favicon并将网址添加到startpage
"""

import os
import sys
import re
import base64
import requests
from urllib.parse import urljoin, urlparse
from bs4 import BeautifulSoup
import argparse
from pathlib import Path


class BookmarkAdder:
    def __init__(self):
        self.script_dir = Path(__file__).parent
        self.icons_dir = self.script_dir / "icons"
        self.index_file = self.script_dir / "index.html"

        # 确保icons目录存在
        self.icons_dir.mkdir(exist_ok=True)

        # 设置请求头
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }

    def get_bookmark_column_count(self):
        """读取当前HTML中的书签列数"""
        try:
            with open(self.index_file, 'r', encoding='utf-8') as f:
                soup = BeautifulSoup(f.read(), 'html.parser')

            bookmarks_section = soup.find('section', id='bookmarks')
            if not bookmarks_section:
                raise ValueError("找不到bookmarks部分")

            return len(bookmarks_section.find_all('ul', recursive=False))
        except Exception as e:
            raise ValueError(f"无法读取书签列数: {e}") from e

    def format_html(self, soup):
        """格式化HTML输出"""
        formatted_html = soup.prettify(formatter="minimal")

        if formatted_html.lstrip().lower().startswith('<!doctype html>'):
            lines = formatted_html.splitlines()
            lines[0] = '<!doctype html>'
            formatted_html = '\n'.join(lines)

        return formatted_html + '\n'

    def normalize_url(self, url):
        """补全URL协议"""
        if not url.startswith(('http://', 'https://')):
            return 'https://' + url
        return url

    def build_icon_filename(self, site_name, content_type=None):
        """根据站点名称和内容类型生成图标文件名"""
        safe_name = re.sub(r'[^\w\-_]', '', site_name.lower().replace(' ', ''))
        extension = '.ico'

        if content_type:
            if 'svg' in content_type:
                extension = '.svg'
            elif 'png' in content_type:
                extension = '.png'
            elif 'jpeg' in content_type or 'jpg' in content_type:
                extension = '.jpg'
            elif 'gif' in content_type:
                extension = '.gif'
            elif 'webp' in content_type:
                extension = '.webp'

        return f"{safe_name}{extension}"

    def prompt_overwrite_existing_icon(self, favicon_path):
        """处理图标文件已存在时的覆盖逻辑"""
        if not favicon_path.exists():
            return True

        try:
            response = input(f"图标文件 {favicon_path.name} 已存在，是否覆盖？(y/N): ")
            return response.lower() == 'y'
        except EOFError:
            print(f"图标文件 {favicon_path.name} 已存在，使用现有文件")
            return False

    def get_site_name(self, url):
        """从URL获取网站名称"""
        try:
            response = requests.get(url, headers=self.headers, timeout=10)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')

            # 尝试获取网站标题
            title_tag = soup.find('title')
            if title_tag:
                title = title_tag.get_text().strip()
                # 移除常见的后缀
                title = re.sub(r'\s*[-|–]\s*.+$', '', title)
                return title

            # 如果没有标题，使用域名
            domain = urlparse(url).netloc
            return domain.replace('www.', '').split('.')[0].title()

        except Exception as e:
            print(f"警告: 无法获取网站标题: {e}")
            # 使用域名作为后备
            domain = urlparse(url).netloc
            return domain.replace('www.', '').split('.')[0].title()

    def find_favicon_urls(self, url):
        """查找网站的favicon URL"""
        favicon_urls = []

        try:
            response = requests.get(url, headers=self.headers, timeout=10)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')

            # 查找各种favicon链接
            favicon_selectors = [
                'link[rel="icon"]',
                'link[rel="shortcut icon"]',
                'link[rel="apple-touch-icon"]',
                'link[rel="apple-touch-icon-precomposed"]'
            ]

            for selector in favicon_selectors:
                for link in soup.select(selector):
                    href = link.get('href')
                    if href:
                        favicon_urls.append(urljoin(url, href))

            # 如果没找到，尝试默认位置
            if not favicon_urls:
                parsed_url = urlparse(url)
                default_favicon = f"{parsed_url.scheme}://{parsed_url.netloc}/favicon.ico"
                favicon_urls.append(default_favicon)

        except Exception as e:
            print(f"警告: 无法解析网页: {e}")
            # 使用默认favicon位置
            parsed_url = urlparse(url)
            default_favicon = f"{parsed_url.scheme}://{parsed_url.netloc}/favicon.ico"
            favicon_urls.append(default_favicon)

        return favicon_urls

    def save_base64_favicon(self, favicon_url, site_name):
        """保存base64内联favicon"""
        match = re.match(r'^data:(image/[^;]+);base64,(.+)$', favicon_url, re.IGNORECASE | re.DOTALL)
        if not match:
            return None

        content_type = match.group(1).lower()
        payload = re.sub(r'\s+', '', match.group(2))
        favicon_path = self.icons_dir / self.build_icon_filename(site_name, content_type)

        if not self.prompt_overwrite_existing_icon(favicon_path):
            return favicon_path.name

        try:
            with open(favicon_path, 'wb') as f:
                f.write(base64.b64decode(payload, validate=True))
            print(f"✓ 成功保存base64 favicon: {favicon_path.name}")
            return favicon_path.name
        except Exception as e:
            print(f"保存base64 favicon失败: {e}")
            return None

    def fetch_favicon_content(self, favicon_urls, site_name=None):
        """抓取favicon内容，返回文件名和二进制内容"""
        for favicon_url in favicon_urls:
            try:
                print(f"尝试下载favicon: {favicon_url}")

                if favicon_url.startswith('data:image/'):
                    match = re.match(r'^data:(image/[^;]+);base64,(.+)$', favicon_url, re.IGNORECASE | re.DOTALL)
                    if not match:
                        continue

                    content_type = match.group(1).lower()
                    payload = re.sub(r'\s+', '', match.group(2))
                    content = base64.b64decode(payload, validate=True)
                    filename = self.build_icon_filename(site_name, content_type) if site_name else None
                    return filename, content

                response = requests.get(favicon_url, headers=self.headers, timeout=10)
                response.raise_for_status()

                content_type = response.headers.get('content-type', '').lower()
                if 'image' not in content_type:
                    continue

                filename = self.build_icon_filename(site_name, content_type) if site_name else None
                return filename, response.content

            except Exception as e:
                print(f"下载失败: {e}")
                continue

        return None, None

    def download_favicon(self, favicon_urls, site_name):
        """下载favicon并保存"""
        favicon_filename, favicon_content = self.fetch_favicon_content(favicon_urls, site_name)
        if favicon_filename and favicon_content is not None:
            favicon_path = self.icons_dir / favicon_filename
            if not self.prompt_overwrite_existing_icon(favicon_path):
                return favicon_path.name

            with open(favicon_path, 'wb') as f:
                f.write(favicon_content)
            print(f"✓ 成功下载favicon: {favicon_path.name}")
            return favicon_path.name

        # 如果所有下载都失败，创建一个默认图标或返回None
        print("⚠ 无法下载favicon，将使用默认图标")
        return None

    def read_bookmarks(self):
        """读取所有书签节点"""
        with open(self.index_file, 'r', encoding='utf-8') as f:
            soup = BeautifulSoup(f.read(), 'html.parser')

        bookmarks_section = soup.find('section', id='bookmarks')
        if not bookmarks_section:
            raise ValueError("找不到bookmarks部分")

        ul_elements = bookmarks_section.find_all('ul', recursive=False)
        return soup, ul_elements

    def refresh_bookmark_icons(self):
        """刷新所有书签图标，仅在获取到新图标时覆盖"""
        try:
            soup, ul_elements = self.read_bookmarks()
        except Exception as e:
            print(f"❌ 读取书签失败: {e}")
            return False

        updated = 0
        unchanged = 0
        failed = 0
        html_changed = False
        cleanup_sources = set()

        for column_index, ul in enumerate(ul_elements, start=1):
            for li in ul.find_all('li', recursive=False):
                anchor = li.find('a', href=True)
                if not anchor:
                    continue

                url = anchor['href'].strip()
                site_name = anchor.get_text(" ", strip=True)
                icon = anchor.find('img', class_='favicon')
                current_src = icon.get('src') if icon else None
                current_path = self.script_dir / current_src if current_src else None

                print(f"\n处理第{column_index}列书签: {site_name} ({url})")
                favicon_urls = self.find_favicon_urls(url)
                new_filename, new_content = self.fetch_favicon_content(favicon_urls, site_name)

                if not new_filename or new_content is None:
                    print("跳过: 没拿到新图标，保留原文件")
                    failed += 1
                    continue

                new_src = f"icons/{new_filename}"
                new_path = self.icons_dir / new_filename

                current_bytes = None
                if current_path and current_path.exists():
                    current_bytes = current_path.read_bytes()

                if current_bytes == new_content and current_src == new_src:
                    print("跳过: 图标内容未变化")
                    unchanged += 1
                    continue

                if new_path.exists():
                    existing_target_bytes = new_path.read_bytes()
                    if existing_target_bytes != new_content:
                        new_path.write_bytes(new_content)
                        print(f"✓ 已覆盖图标文件: {new_filename}")
                    else:
                        print(f"✓ 复用已有图标文件: {new_filename}")
                else:
                    new_path.write_bytes(new_content)
                    print(f"✓ 已写入新图标文件: {new_filename}")

                if icon:
                    icon['src'] = new_src
                    icon['alt'] = f'{site_name} favicon'
                else:
                    new_img = soup.new_tag('img', src=new_src, **{'class': 'favicon', 'alt': f'{site_name} favicon'})
                    anchor.insert(0, new_img)
                    anchor.insert(1, ' ')

                if current_src and current_src != new_src:
                    cleanup_sources.add(current_src)

                updated += 1
                html_changed = True

        if html_changed:
            with open(self.index_file, 'w', encoding='utf-8') as f:
                f.write(self.format_html(soup))

            for old_src in cleanup_sources:
                self.remove_unused_icon(old_src, soup=soup)

        print(f"\n刷新完成: 更新 {updated} 个，未变化 {unchanged} 个，跳过 {failed} 个")
        return True

    def remove_unused_icon(self, favicon_src, soup=None):
        """在图标未被其他书签引用时删除图标文件"""
        if not favicon_src or not favicon_src.startswith('icons/'):
            return

        icon_rel_path = Path(favicon_src)
        icon_path = self.script_dir / icon_rel_path
        if not icon_path.exists():
            return

        try:
            if soup is None:
                with open(self.index_file, 'r', encoding='utf-8') as f:
                    soup = BeautifulSoup(f.read(), 'html.parser')

            remaining_refs = soup.select(f'img.favicon[src="{favicon_src}"]')
            if remaining_refs:
                return

            icon_path.unlink()
            print(f"✓ 已删除未使用图标: {icon_rel_path.name}")
        except Exception as e:
            print(f"警告: 清理图标失败: {e}")

    def remove_bookmark_from_html(self, url=None, site_name=None, column=None):
        """从HTML文件中删除书签"""
        try:
            with open(self.index_file, 'r', encoding='utf-8') as f:
                soup = BeautifulSoup(f.read(), 'html.parser')

            bookmarks_section = soup.find('section', id='bookmarks')
            if not bookmarks_section:
                raise ValueError("找不到bookmarks部分")

            ul_elements = bookmarks_section.find_all('ul', recursive=False)

            if column is not None:
                if column < 1 or column > len(ul_elements):
                    raise ValueError(f"列数必须在1-{len(ul_elements)}之间")
                search_columns = [(column, ul_elements[column - 1])]
            else:
                search_columns = list(enumerate(ul_elements, start=1))

            matched_li = None
            matched_column = None
            matched_text = None
            matched_href = None
            matched_icon = None

            normalized_url = self.normalize_url(url) if url else None

            for current_column, ul in search_columns:
                for li in ul.find_all('li', recursive=False):
                    anchor = li.find('a', href=True)
                    if not anchor:
                        continue

                    anchor_href = anchor['href'].strip()
                    anchor_text = anchor.get_text(" ", strip=True)

                    name_match = site_name and anchor_text == site_name
                    url_match = normalized_url and anchor_href == normalized_url

                    if name_match or url_match:
                        matched_li = li
                        matched_column = current_column
                        matched_text = anchor_text
                        matched_href = anchor_href
                        icon = anchor.find('img', class_='favicon')
                        matched_icon = icon.get('src') if icon else None
                        break

                if matched_li:
                    break

            if not matched_li:
                print("❌ 未找到匹配的书签")
                return False

            matched_li.decompose()

            with open(self.index_file, 'w', encoding='utf-8') as f:
                f.write(self.format_html(soup))

            print(f"✓ 成功删除书签: {matched_text} ({matched_href})，位于第{matched_column}列")
            self.remove_unused_icon(matched_icon)
            return True

        except Exception as e:
            print(f"❌ 删除书签失败: {e}")
            return False

    def add_bookmark_to_html(self, url, site_name, favicon_filename, column, position=None):
        """将书签添加到HTML文件"""
        try:
            with open(self.index_file, 'r', encoding='utf-8') as f:
                content = f.read()

            # 使用BeautifulSoup解析HTML
            soup = BeautifulSoup(content, 'html.parser')

            # 查找bookmarks部分
            bookmarks_section = soup.find('section', id='bookmarks')
            if not bookmarks_section:
                raise ValueError("找不到bookmarks部分")

            # 查找bookmarks中的所有ul元素
            ul_elements = bookmarks_section.find_all('ul', recursive=False)

            if len(ul_elements) < column:
                raise ValueError(f"列数超出范围，当前只有{len(ul_elements)}列")

            # 创建新的li元素
            new_li = soup.new_tag('li')
            new_a = soup.new_tag('a', href=url, target='_blank')

            if favicon_filename:
                new_img = soup.new_tag('img',
                                     src=f'icons/{favicon_filename}',
                                     **{'class': 'favicon', 'alt': f'{site_name} favicon'})
                new_a.append(new_img)

            new_a.append(site_name)
            new_li.append(new_a)

            # 将新书签添加到指定列的指定位置
            target_ul = ul_elements[column - 1]
            existing_items = target_ul.find_all('li')

            if position is None or position > len(existing_items):
                # 默认添加到末尾
                target_ul.append(new_li)
            else:
                # 插入到指定位置 (position从1开始计数)
                if position <= 1:
                    target_ul.insert(0, new_li)
                else:
                    # 在指定位置插入
                    existing_items[position - 2].insert_after(new_li)

            # 写回文件并格式化HTML
            formatted_html = self.format_html(soup)

            with open(self.index_file, 'w', encoding='utf-8') as f:
                f.write(formatted_html)

            print(f"✓ 成功添加书签到第{column}列")

        except Exception as e:
            print(f"❌ 添加书签到HTML失败: {e}")
            return False

        return True

    def add_bookmark(self, url, column, site_name=None, position=None):
        """添加书签的主要方法"""
        url = self.normalize_url(url)

        print(f"正在处理URL: {url}")

        # 获取网站名称
        if not site_name:
            site_name = self.get_site_name(url)
            print(f"检测到网站名称: {site_name}")

            # 询问用户是否要修改名称
            user_input = input(f"网站名称 [{site_name}] (按回车确认或输入新名称): ").strip()
            if user_input:
                site_name = user_input

        # 查找并下载favicon
        favicon_urls = self.find_favicon_urls(url)
        favicon_filename = self.download_favicon(favicon_urls, site_name)

        # 添加到HTML
        success = self.add_bookmark_to_html(url, site_name, favicon_filename, column, position)

        if success:
            print(f"\n🎉 成功添加书签:")
            print(f"   名称: {site_name}")
            print(f"   URL: {url}")
            print(f"   列数: {column}")
            if position:
                print(f"   位置: 第{position}行")
            if favicon_filename:
                print(f"   图标: {favicon_filename}")

        return success

    def remove_bookmark(self, url=None, site_name=None, column=None):
        """删除书签的主要方法"""
        if not url and not site_name:
            print("❌ 删除时必须提供URL或网站名称")
            return False

        if url:
            url = self.normalize_url(url)
            print(f"正在删除URL: {url}")
        elif site_name:
            print(f"正在删除名称为 {site_name} 的书签")

        return self.remove_bookmark_from_html(url=url, site_name=site_name, column=column)


def main():
    argv = sys.argv[1:]
    if argv and argv[0] not in {'add', 'remove', 'refresh-icons', '-h', '--help'}:
        argv = ['add', *argv]

    parser = argparse.ArgumentParser(description='管理startpage书签')
    subparsers = parser.add_subparsers(dest='command')

    add_parser = subparsers.add_parser('add', help='添加书签')
    add_parser.add_argument('url', help='要添加的网址')
    add_parser.add_argument('column', type=int, help='添加到第几列')
    add_parser.add_argument('-n', '--name', help='自定义网站名称')
    add_parser.add_argument('-p', '--position', type=int, help='插入到第几行 (从1开始，默认添加到末尾)')

    remove_parser = subparsers.add_parser('remove', help='删除书签')
    remove_parser.add_argument('-u', '--url', help='按URL删除书签')
    remove_parser.add_argument('-n', '--name', help='按显示名称删除书签')
    remove_parser.add_argument('-c', '--column', type=int, help='仅在指定列中查找 (从1开始)')

    subparsers.add_parser('refresh-icons', help='刷新所有书签图标')

    parser.set_defaults(command='add')

    args = parser.parse_args(argv)

    adder = BookmarkAdder()

    if args.command == 'remove':
        if not args.url and not args.name:
            parser.error("remove 需要提供 --url 或 --name")
        success = adder.remove_bookmark(args.url, args.name, args.column)
    elif args.command == 'refresh-icons':
        success = adder.refresh_bookmark_icons()
    else:
        max_columns = adder.get_bookmark_column_count()
        if args.column < 1 or args.column > max_columns:
            print(f"❌ 列数必须在1-{max_columns}之间")
            return

        success = adder.add_bookmark(args.url, args.column, args.name, args.position)

    if not success:
        sys.exit(1)


if __name__ == "__main__":
    # 如果没有命令行参数，使用交互模式
    if len(sys.argv) == 1:
        print("=== 书签添加工具 ===")
        print("按 Ctrl+C 随时退出\n")

        try:
            adder = BookmarkAdder()
            max_columns = adder.get_bookmark_column_count()

            while True:
                print("\n" + "="*50)
                url = input("请输入网址: ").strip()
                if not url:
                    continue

                column = input(f"请输入列数 (1-{max_columns}): ").strip()
                try:
                    column = int(column)
                    if column < 1 or column > max_columns:
                        print(f"❌ 列数必须在1-{max_columns}之间")
                        continue
                except ValueError:
                    print("❌ 请输入有效的数字")
                    continue

                position = input("插入到第几行 (可选，按回车添加到末尾): ").strip()
                try:
                    position = int(position) if position else None
                    if position is not None and position < 1:
                        print("❌ 行数必须大于0")
                        continue
                except ValueError:
                    print("❌ 请输入有效的数字")
                    continue

                name = input("自定义网站名称 (可选，按回车跳过): ").strip()
                if not name:
                    name = None

                print("\n开始添加书签...")
                success = adder.add_bookmark(url, column, name, position)

                if success:
                    cont = input("\n是否继续添加其他书签? (Y/n): ")
                    if cont.lower() == 'n':
                        break
                else:
                    retry = input("\n是否重试? (y/N): ")
                    if retry.lower() != 'y':
                        break

        except KeyboardInterrupt:
            print("\n\n👋 再见!")
    else:
        main()
