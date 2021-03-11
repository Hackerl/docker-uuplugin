FROM openwrtorg/rootfs:x86-64-19.07.7

ARG UU_IP=172.17.0.10
ARG UU_GATEWAY=172.17.0.1
ARG UU_NETMASK=255.255.0.0

RUN mkdir /var/lock
RUN opkg update
RUN opkg install libustream-mbedtls ca-certificates kmod-tun

ADD uu_install /etc/init.d/uu_install

RUN /etc/init.d/uu_install enable
RUN /etc/init.d/dnsmasq disable
RUN /etc/init.d/odhcpd disable
RUN /etc/init.d/firewall disable
RUN /etc/init.d/uhttpd disable
RUN /etc/init.d/dropbear disable

ADD config.sh /config.sh
RUN sh /config.sh
RUN rm /config.sh
