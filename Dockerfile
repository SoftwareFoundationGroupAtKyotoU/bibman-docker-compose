FROM debian

RUN apt-get update \
    && apt-get install -y \
    apache2 \
    camlp4-extra \
    exim4 \
    libgmp-dev \
    libpcre3-dev \
    mccs \
    opam \
    pkg-config \
    wget \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN opam init -a --disable-sandboxing \
    && opam switch create 4.06.1 

RUN opam install -y \
    batteries \
    config-file \
    cryptokit \
    ocamlnet \
    omake \
    pcre \
    pgocaml.3.2 \
    yojson \
    text

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY bibman.conf /etc/apache2/sites-enabled/000-default.conf
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn \
    && a2enmod cgid rewrite

COPY update-exim4.conf.conf /etc/exim4/update-exim4.conf.conf

COPY bibman /var/www/bibman/

COPY run.sh /run.sh
