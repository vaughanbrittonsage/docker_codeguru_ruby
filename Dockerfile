FROM alpine:3.3

#add openssh
RUN apk add --update --no-cache openssh \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd \
  && ssh-keygen -A

#add ruby and bundler
RUN apk add --no-cache ruby ruby-bigdecimal ruby-irb ruby-bundler

#add openssl & bash
RUN apk add --update --no-cache bash openssl

#add debug gems
RUN set -ex \
&& apk add --no-cache --virtual .gem-builddeps \
    autoconf \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    coreutils \
    curl \
    gcc \
    gdbm-dev \
    glib-dev \
    libc-dev \
    libedit-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    ncurses-dev \
    openssl-dev \
    procps \
    ruby-dev \
&& gem install ruby-debug-ide --no-ri --no-rdoc \
&& gem install debase --no-ri --no-rdoc \
&& gem install debug_inspector --no-ri --no-rdoc \
&& gem install binding_of_caller --no-ri --no-rdoc \
&& gem install io-console --no-ri --no-rdoc \
&& apk del .gem-builddeps
