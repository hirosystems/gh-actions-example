FROM alpine

RUN apk add --no-cache --update \
      py-setuptools \
      py-pip \
      gcc \
      libffi \
      py-cffi \
      python3-dev \
      libffi-dev \
      py-openssl \
      musl-dev \
      linux-headers \
      openssl-dev \
      libssl1.1 \
      libgcc \
      curl \
      yaml-dev \
      yaml

CMD [ "/bin/sh", "-c", "echo 'hello world'" ]
