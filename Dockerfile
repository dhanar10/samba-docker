FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

COPY docker-host-acng-discover.sh /usr/bin

RUN chmod +x /usr/bin/docker-host-acng-discover.sh \
    && echo 'Acquire::http::ProxyAutoDetect "/usr/bin/docker-host-acng-discover.sh";' \
       | tee /etc/apt/apt.conf.d/90autoproxy

RUN apt-get update \  
	&& apt-get install --no-install-recommends -y \
        samba \
	&& rm -rf /var/lib/apt/lists/*

COPY smb.conf /etc/samba/smb.conf

VOLUME /storage

EXPOSE 139/tcp 445/tcp

CMD ["smbd", "--foreground", "--log-stdout", "--no-process-group"]
