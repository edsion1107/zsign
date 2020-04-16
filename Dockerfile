FROM alpine:3.11
WORKDIR /zsign
COPY . src/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tencent.com/g' /etc/apk/repositories && \
	apk add --no-cache --virtual .build-deps g++ openssl-dev && \
	apk add --no-cache libgcc libstdc++ zip unzip && \
	g++ src/*.cpp src/common/*.cpp -lcrypto -O3 -o zsign && \
	apk del .build-deps && \
	rm -rf src

ENTRYPOINT ["/zsign/zsign"]
CMD ["--help"]