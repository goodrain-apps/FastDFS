# centos 7
FROM centos
# 添加配置文件
ADD conf/client.conf /etc/conf/
ADD conf/http.conf /etc/conf/
ADD conf/mime.types /etc/conf/
ADD conf/storage.conf /etc/conf/
ADD conf/tracker.conf /etc/conf/
ADD fastdfs.sh /home
ADD conf/nginx.conf /etc/conf/
ADD conf/mod_fastdfs.conf /etc/conf

# run
RUN yum install git gcc gcc-c ++ make automake autoconf libtool pcre pcre-devel zlib zlib-devel openssl-devel wget vim -y \
  &&    cd /usr/local/src  \
  &&    git clone https://github.com/happyfish100/libfastcommon.git --depth 1        \
  &&    git clone https://github.com/happyfish100/fastdfs.git --depth 1    \
  &&    git clone https://github.com/happyfish100/fastdfs-nginx-module.git --depth 1   \
  &&    wget http://nginx.org/download/nginx-1.15.4.tar.gz    \
  &&    tar -zxvf nginx-1.15.4.tar.gz \
  &&    mkdir /home/dfs   \
  &&    cd /usr/local/src/  \
  &&    cd libfastcommon/   \
  &&    ./make.sh && ./make.sh install  \
  &&    cd ../  \
  &&    cd fastdfs/   \
  &&    ./make.sh && ./make.sh install  \
  &&    cd ../  \
  &&    cd nginx-1.15.4/  \
  &&    ./configure --add-module=/usr/local/src/fastdfs-nginx-module/src/   \
  &&    make && make install  \
  &&    chmod +x /home/fastdfs.sh


# export config
VOLUME /etc/fdfs

EXPOSE 22122 23000 8888 80
ENTRYPOINT ["/home/fastdfs.sh"]
