#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
快速添加书签脚本
用于自动下载favicon并将网址添加到startpage
"""

import os
import sys
import re
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

    def download_favicon(self, favicon_urls, site_name):
        """下载favicon并保存"""
        # 生成文件名
        safe_name = re.sub(r'[^\w\-_]', '', site_name.lower().replace(' ', ''))
        favicon_path = self.icons_dir / f"{safe_name}.ico"

        # 如果文件已存在，询问是否覆盖
        if favicon_path.exists():
            try:
                response = input(f"图标文件 {favicon_path.name} 已存在，是否覆盖？(y/N): ")
                if response.lower() != 'y':
                    return favicon_path.name
            except EOFError:
                # 非交互环境，默认不覆盖
                print(f"图标文件 {favicon_path.name} 已存在，使用现有文件")
                return favicon_path.name

        # 尝试下载favicon
        for favicon_url in favicon_urls:
            try:
                print(f"尝试下载favicon: {favicon_url}")
                response = requests.get(favicon_url, headers=self.headers, timeout=10)
                response.raise_for_status()

                # 检查内容类型
                content_type = response.headers.get('content-type', '').lower()
                if 'image' in content_type:
                    with open(favicon_path, 'wb') as f:
                        f.write(response.content)
                    print(f"✓ 成功下载favicon: {favicon_path.name}")
                    return favicon_path.name

            except Exception as e:
                print(f"下载失败: {e}")
                continue

        # 如果所有下载都失败，创建一个默认图标或返回None
        print("⚠ 无法下载favicon，将使用默认图标")
        return None

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

            # 写回文件，保持原有格式
            formatted_html = str(soup)
            # 修复BeautifulSoup的格式问题
            formatted_html = formatted_html.replace('<!DOCTYPE html>', '<!doctype html>')

            with open(self.index_file, 'w', encoding='utf-8') as f:
                f.write(formatted_html)

            print(f"✓ 成功添加书签到第{column}列")

        except Exception as e:
            print(f"❌ 添加书签到HTML失败: {e}")
            return False

        return True

    def add_bookmark(self, url, column, site_name=None, position=None):
        """添加书签的主要方法"""
        # 验证URL
        if not url.startswith(('http://', 'https://')):
            url = 'https://' + url

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


def main():
    parser = argparse.ArgumentParser(description='快速添加书签到startpage')
    parser.add_argument('url', help='要添加的网址')
    parser.add_argument('column', type=int, help='添加到第几列 (1-4)')
    parser.add_argument('-n', '--name', help='自定义网站名称')
    parser.add_argument('-p', '--position', type=int, help='插入到第几行 (从1开始，默认添加到末尾)')

    args = parser.parse_args()

    # 验证列数
    if args.column < 1 or args.column > 4:
        print("❌ 列数必须在1-4之间")
        return

    # 创建BookmarkAdder实例并添加书签
    adder = BookmarkAdder()
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

            while True:
                print("\n" + "="*50)
                url = input("请输入网址: ").strip()
                if not url:
                    continue

                column = input("请输入列数 (1-4): ").strip()
                try:
                    column = int(column)
                    if column < 1 or column > 4:
                        print("❌ 列数必须在1-4之间")
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
