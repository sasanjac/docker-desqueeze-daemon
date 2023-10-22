FROM lsiobase/alpine:3.18

LABEL version="0.1.0"
LABEL repository="https://github.com/sasanjac/docker-desqueeze-daemon"

# install dependencies
RUN \
	echo "**** install packages ****" && \
	apk add --no-cache \
	git \
	exiftool \
	imagemagick \
	rustup \
	cargo \
	python3 && \
	python3 -m ensurepip && \
	python3 -m pip install --no-cache-dir --upgrade pip && \
	git clone https://github.com/dnglab/dnglab.git && \
	cd dnglab && \
	cargo build --release && \
	echo "**** clean up ****" && \
	rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /data/import /data/export