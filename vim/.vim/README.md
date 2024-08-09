### 效果图：

![img](https://github.com/bighu630/img/blob/main/vim01.png)

![vim](https://github.com/bighu630/img/blob/main/vim.gif)



### 具体配置：

```
cd ~
git clone https://github.com/bighu630/vimrc.git
rm -rf .vim
mv vimrc .vim
```

初次运行vim会报错，回车进入vim后使用：PlugInstall安装完插件即可

此时YCM是还没配置好语言的

```
cd ~/.vim/plugged/YouCompleteMe
./install.py --all  """可以指定语言安装
```



### 要求：

vim8.1及以上（目前只测试了8.1）

vim支持python2／3（只需一个python）



### 不合要求的解决方法：

使用vim --version查看vim版本和是否支持python

若vim不支持python2／3

卸载vim,然后安装vim-youcompleteme

debian系：sudo apt install vim-youcompleteme



### 其他问题：

法一:不使用*YCM*的代码补全方案

具体将配置文件中的*Plug 'Valloric/YouCompleteMe'*注释掉

可以使用其他的代码补全插件

eg:  

  "Plug 'Valloric/YouCompleteMe'
  
  Plug 'skywind3000/vim-auto-popmenu'
  
  Plug 'skywind3000/vim-dict'

![img](https://github.com/bighu630/img/blob/main/vim02.png)

法二：使用vim的源码编译安装（一定要注意vim的版本和配置python）

在下试过，没成功






