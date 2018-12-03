FROM ubuntu:bionic AS build

RUN apt-get update \
&& apt-get install -y \
   git \
   autoconf \
   python \
   pkg-config \
   libtool \
   libfdt-dev \
   libpixman-1-dev \
   libssl-dev \
   libspice-server-dev \
   liblzma-dev \
   libc6-dev \
   libglib2.0-dev \
   libgbm-dev \
   libepoxy-dev \
   libegl1-mesa-dev \
   libdrm-dev \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN git clone --depth=1 -b v3.1.0-rc3 https://github.com/qemu/qemu \
&& cd qemu \
&& ./configure \
     --enable-kvm \
     --enable-spice \
     --enable-vnc \
     --enable-opengl \
     --target-list=x86_64-softmmu \
&& make -j$(nproc) \
&& make install

FROM ubuntu:bionic

RUN apt-get update \
&& apt-get install -y \
   libfdt1 \
   libpixman-1-0 \
   libssl1.1 \
   libspice-server1 \
   liblzma5 \
   libc6 \
   libglib2.0-0 \
   libgbm1 \
   libepoxy0 \
   libegl1-mesa \
   libdrm2 \
&& rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/ /usr/local/
