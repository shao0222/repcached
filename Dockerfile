#
# Memcached Repcached Dockerfile
#
#

# Pull base image.
FROM centos:centos6

MAINTAINER wjw465150 <wjw465150@gmail.com>

# Install dependence.
RUN \
  yum -y install unzip tar wget gcc make file automake autoconf libtool patch nc

#wget http://www.monkey.org/~provos/libevent-1.4.13-stable.tar.gz && \
COPY ./libevent-1.4.13-stable.tar.gz /tmp/

RUN cd /tmp/ && \
 tar zxvf ./libevent-1.4.13-stable.tar.gz && \
 cd ./libevent-1.4.13-stable && \
 ./configure --prefix=/usr/local && \
 make uninstall && \
 make clean && \
 make && \
 make install
  
COPY ./memcached-1.4.13-repcached-2.3.1.tar.gz /tmp/

RUN cd /tmp && \
 tar -zxvf ./memcached-1.4.13-repcached-2.3.1.tar.gz

COPY ./memcached-1.4.13-cachedump-hack /tmp/

RUN cd /tmp/memcached-1.4.13-repcached-2.3.1 && \
 patch -p1 -i /tmp/memcached-1.4.13-cachedump-hack && \
 ./configure --with-libevent=/usr/local/lib/ --enable-replication --enable-64bit && \
 make && \
 make install

RUN ln -s /usr/local/lib/libevent-1.4.so.2 /usr/lib64/libevent-1.4.so.2 && \ 
 rm -rf /tmp/*

# Expose ports.
EXPOSE 11311 11411
  
ENTRYPOINT ["/usr/local/bin/memcached"]
CMD ["-h"]
#run时可传递如下参数:-m 200 -v -u root -l 0.0.0.0 -p 11311 -X 11411
