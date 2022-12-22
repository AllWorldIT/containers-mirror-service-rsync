FROM registry.gitlab.iitsp.com/allworldit/docker/alpine:latest

ARG VERSION_INFO=
LABEL maintainer="Nigel Kukard <nkukard@lbsd.net>"

RUN set -ex; \
	true "Rsync"; \
	apk add --no-cache rsync; \
	true "Versioning"; \
	if [ -n "$VERSION_INFO" ]; then echo "$VERSION_INFO" >> /.VERSION_INFO; fi; \
	true "Cleanup"; \
	rm -f /var/cache/apk/*


# Rsyncd
COPY etc/supervisor/conf.d/rsyncd.conf /etc/supervisor/conf.d/rsyncd.conf
COPY etc/rsyncd.conf /etc/rsyncd.conf
COPY pre-init-tests.d/50-rsyncd.sh /docker-entrypoint-pre-init-tests.d/50-rsyncd.sh
COPY tests.d/60-rsyncd.sh /docker-entrypoint-tests.d/60-rsyncd.sh
RUN set -ex; \
		mkdir /etc/rsyncd.conf.d /data; \
		chown root:root \
			/etc/rsyncd.conf.d \
			/data \
			/etc/supervisor/conf.d/rsyncd.conf \
			/docker-entrypoint-pre-init-tests.d/50-rsyncd.sh \
			/docker-entrypoint-tests.d/60-rsyncd.sh; \
		chmod 0644 \
			/etc/supervisor/conf.d/rsyncd.conf; \
		chmod 0755 \
			/etc/rsyncd.conf.d \
			/data \
			/docker-entrypoint-tests.d/60-rsyncd.sh

VOLUME ["/data"]

EXPOSE 873

# Health check
HEALTHCHECK CMD rsync -L localhost::

