# 配置源

使用清华源

```shell
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list
apt update && apt upgrade
```

# 安装atilo

```shell
echo "deb [trusted=yes arch=all] https://yadominjinta.github.io/files/ termux extras" >> $PREFIX/etc/apt/sources.list
apt update && apt install atilo-cn
```

# nginx 安装各种模块

```
./configure --with-http_dav_module --add-module=../nginx-dav-ext-module --with-http_ssl_module --add-module=../nginx-rtmp-module
```

# 安装ohmyzsh

```shell
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
apt update && apt upgrade
apt install curl zsh git

sh -c "$(curl -fsSL https://gitee.com/sherkeyxd/termux-ohmyzsh/raw/master/install.sh)"
```



# python3.11 安装包
```shell
python3.11 -m venv myenv
source myenv/bin/activate
pip install <package_name>
```

# ssh

openssh没法用，用dropbear！

```shell
dropbear -FE -p 18022 
```

# wget无法下载https解决

```shell
sudo apt-get install ca-certificates
sudo update-ca-certificates
```

# 编译安装boost

```shell

sudo apt-get install build-essential g++ python-dev autotools-dev libicu-dev build-essential libbz2-dev libboost-all-dev

wget https://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz
tar -zxvf boost_1_59_0.tar.gz

cd boost_1_59_0

./bootstrap.sh --prefix=/usr/

sudo ./b2 install


```

# 编译安装openssl

```shell
# 下载对应版本
wget https://www.openssl.org/source/openssl-1.1.1.tar.gz
wget https://www.openssl.org/source/openssl-1.1.1k.tar.gz
wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz

tar -xzvf openssl-1.1.1.tar.gz

cd openssl-1.1.1

./config

make

make install

```

# 编译安装mysql

```shell

wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.26.tar.gz
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.34.tar.gz

tar -xzvf mysql-8.0.26.tar.gz

cd mysql-8.0.26

sudo apt-get install cmake libncurses5-dev libaio1 libmecab-dev

mkdir build && cd build

cmake ..

make

sudo make install

# 安装pkg-config
sudo apt-get install pkg-config

```