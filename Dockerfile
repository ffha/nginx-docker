FROM alpine
ENV NGINX_VERSION 1.22.0
RUN apk add --no-cache build-base make wget zlib-dev openssl-dev libxml2-dev libxslt-dev geoip-dev pcre2-dev
WORKDIR /usr/src
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && tar xzf nginx-${NGINX_VERSION}.tar.gz
WORKDIR /usr/src/nginx-${NGINX_VERSION}
RUN ./configure --prefix=/usr/share/nginx --sbin-path=/sbin/nginx --modules-path=/usr/lib/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/dev/stderr --pid-path=/run/nginx.pid --lock-path=/run/nginx.lock --with-threads --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_stub_status_module --http-log-path=/dev/stdout --http-client-body-temp-path=/tmp/client_body_tmp --http-proxy-temp-path=/tmp/proxy_tmp --http-fastcgi-temp-path=/tmp/fcgi_tmp --http-uwsgi-temp-path=/tmp/uwsgi_tmp --http-scgi-temp-path=/tmp/scgi_tmp --with-stream --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module --with-stream_ssl_preread_module --with-http_geoip_module 
RUN make && make install
RUN apk del build-base make zlib-dev openssl-dev libxml2-dev libxslt-dev geoip-dev pcre2-dev
RUN apk add pcre2 zlib libxslt geoip libssl3 libcrypto3
CMD nginx -g "daemon off;"
