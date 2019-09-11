FROM debian:9-slim as builder
WORKDIR /openconnect
RUN apt update \
    && apt install -y  \
	build-essential \
	gettext \
	autoconf \
	automake \
	libproxy-dev \
	libxml2-dev \
	libtool \
	vpnc-scripts \
	pkg-config \
	libgnutls28-dev \
	git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ADD . .
RUN ./autogen.sh
RUN ./configure
RUN make
RUN clear
RUN echo Connecting to the Florida Polytechnic University VPN...
RUN ./openconnect --protocol=gp vpn.floridapoly.edu
#FROM debian:9-slim
#WORKDIR /openconnect
#COPY --from=builder /openconnect .
#RUN make install
#RUN ldconfig
