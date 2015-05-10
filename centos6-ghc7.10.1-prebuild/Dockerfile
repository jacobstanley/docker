## Dockerfile to do the prebuild steps for GHC on CentOS 6.x (GMP 4.x)
FROM       jystic/centos6-ghc7.8.4
MAINTAINER Jacob Stanley <jacob@stanley.io>

## Copy GHC install to /tmp
ADD ghc-7.10.1-src.tar.xz /tmp

## GHC install dependencies
RUN yum install \
    perl \
    ncurses-devel \
    tar \
    xz \
    gcc-c++ \
    libstdc++-devel \
    -y

## Install GHC
WORKDIR /tmp/ghc-7.10.1
RUN ./configure --prefix /opt/ghc/7.10.1
RUN make
RUN make install

## Add GHC to PATH
ENV PATH /opt/ghc/7.10.1/bin:$PATH

## Remove old stuff from centos-ghc-7.8.4 container
RUN rm -rf /opt/ghc/7.8.4
RUN rm -rf /opt/alex
RUN rm -rf /opt/happy
RUN rm -rf /opt/c2hs
RUN rm -rf /opt/cabal-install

## Copy cabal-install to /tmp
ADD cabal-install-1.22.4.0.tar.gz /tmp

## cabal-install install dependencies
RUN yum install which -y
RUN yum install gmp-devel -y
RUN yum install zlib-devel -y

## Install cabal-install
WORKDIR /tmp/cabal-install-1.22.4.0
RUN ./bootstrap.sh
RUN mkdir -p /opt/cabal-install/1.22.4.0/bin
RUN mv /root/.cabal/bin/cabal /opt/cabal-install/1.22.4.0/bin/

## Add cabal-install to PATH
ENV PATH /opt/cabal-install/1.22.4.0/bin:$PATH

## Install common Haskell build tools
RUN cabal update
RUN cabal install alex-3.1.4
RUN cabal install happy-1.19.5
RUN cabal install c2hs-0.25.2

## Create global locations for build tools
RUN mkdir -p /opt/alex/3.1.4/bin/
RUN mkdir -p /opt/happy/1.19.5/bin/
RUN mkdir -p /opt/c2hs/0.25.2/bin/

## Copy build tools to global locations
RUN mv /root/.cabal/bin/alex  /opt/alex/3.1.4/bin/
RUN mv /root/.cabal/bin/happy /opt/happy/1.19.5/bin/
RUN mv /root/.cabal/bin/c2hs  /opt/c2hs/0.25.2/bin/

## Install Cabal-1.22.3.0 to match cabal-install-1.22.4.0
RUN cabal install Cabal-1.22.3.0 \
    --global \
    --enable-library-profiling \
    --prefix=/opt/ghc/7.10.1 \
    --libsubdir=\$compiler/\$pkgkey \
    --datasubdir=\$compiler/\$pkgkey \
    --docdir=\$datadir/doc/ghc/html/libraries \
    --htmldir=\$datadir/doc/ghc/html/libraries

## Remove documentation
RUN find /opt/ghc/7.10.1/share/doc -type f | grep -v LICENSE | xargs rm

## Create tarballs so we can copy them off and create a clean image
## without all the above garbage in the layers
ENV XZ_OPT -9e
RUN tar cJf /root/ghc-7.10.1+Cabal-1.22.3.0.tar.xz /opt/ghc
RUN tar cJf /root/cabal-install-1.22.4.0.tar.xz    /opt/cabal-install
RUN tar cJf /root/alex-3.1.4.tar.xz                /opt/alex
RUN tar cJf /root/happy-1.19.5.tar.xz              /opt/happy
RUN tar cJf /root/c2hs-0.25.2.tar.xz               /opt/c2hs
