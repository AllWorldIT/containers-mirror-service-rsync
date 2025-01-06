# Copyright (c) 2022-2025, AllWorldIT.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.


FROM registry.conarx.tech/containers/alpine/3.21


ARG VERSION_INFO=
LABEL org.opencontainers.image.authors   = "Nigel Kukard <nkukard@conarx.tech>"
LABEL org.opencontainers.image.version   = "3.21"
LABEL org.opencontainers.image.base.name = "registry.conarx.tech/containers/alpine/3.21"


RUN set -eux; \
	true "Rsync"; \
	apk add --no-cache \
		rsync; \
	true "Cleanup"; \
	rm -f /var/cache/apk/*


# Rsyncd
COPY etc/supervisor/conf.d/rsyncd.conf /etc/supervisor/conf.d
COPY etc/rsyncd.conf /etc
COPY usr/local/share/flexible-docker-containers/pre-init-tests.d/42-mirror-service-rsyncd.sh /usr/local/share/flexible-docker-containers/pre-init-tests.d
COPY usr/local/share/flexible-docker-containers/tests.d/42-mirror-service-rsyncd.sh /usr/local/share/flexible-docker-containers/tests.d
COPY usr/local/share/flexible-docker-containers/healthcheck.d/42-mirror-service-rsyncd.sh /usr/local/share/flexible-docker-containers/healthcheck.d
RUN set -eux; \
	true "Flexible Docker Containers"; \
	if [ -n "$VERSION_INFO" ]; then echo "$VERSION_INFO" >> /.VERSION_INFO; fi; \
	true "Permissions"; \
	mkdir \
		/etc/rsyncd.conf.d \
		/data; \
	chown root:root \
		/etc/rsyncd.conf.d \
		/data; \
	chmod 0755 \
		/etc/rsyncd.conf.d \
		/data; \
	fdc set-perms


VOLUME ["/data"]

EXPOSE 873
