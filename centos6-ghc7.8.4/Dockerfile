## Dockerfile for GHC on CentOS 6.x (GMP 4.x)
FROM       centos:6
MAINTAINER Jacob Stanley <jacob@stanley.io>

## Install dependencies (gmp-devel has GMP 4.x)
RUN yum install gcc gmp-devel zlib-devel -y

## Add binaries required for Haskell development
ADD ghc-7.8.4+Cabal-1.22.0.0.tar.xz /
ADD cabal-install-1.22.0.0.tar.xz   /
ADD alex-3.1.4.tar.xz               /
ADD happy-1.19.5.tar.xz             /
ADD c2hs-0.22.1.tar.xz              /

## Add bin/ directories to the PATH
ENV PATH /opt/ghc/7.8.4/bin:$PATH
ENV PATH /opt/cabal-install/1.22.0.0/bin:$PATH
ENV PATH /opt/alex/3.1.4/bin/:$PATH
ENV PATH /opt/happy/1.19.5/bin/:$PATH
ENV PATH /opt/c2hs/0.22.1/bin/:$PATH

## Run ghci by default unless a command is specified
CMD ["ghci"]
