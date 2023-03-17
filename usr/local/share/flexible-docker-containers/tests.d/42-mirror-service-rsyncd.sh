#!/bin/bash
# Copyright (c) 2022-2023, AllWorldIT.
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


fdc_test_start mirror-service-rsyncd "Testing Rsync connectivity using IPv4"
OUT_V4_873=$(socat -T2 - "TCP:127.0.0.1:873,end-close" < /dev/null)
if ! grep 'RSYNC' <<< "$OUT_V4_873"; then
	fdc_test_fail mirror-service-rsyncd "Rsync connecitivty test using IPv4 failed"
	false
fi
fdc_test_pass mirror-service-rsyncd "Rsync connectivity over IPv4 working"


fdc_test_start mirror-service-rsyncd "Testing Rsync download using IPv4"
if ! rsync localhost::test/testfile4.txt /tmp/; then
	fdc_test_fail mirror-service-rsyncd "Rsync download test using IPv4 failed"
	false
fi
fdc_test_pass mirror-service-rsyncd "Rsync download using IPv4 working"


fdc_test_start mirror-service-rsyncd "Checking downloaded Rsync file matches test file using IPv4..."
if ! diff /data/testfile4.txt /tmp/testfile4.txt; then
	fdc_test_fail mirror-service-rsyncd "Downloaded file over Rsync does not match test file"
	false
fi
fdc_test_pass mirror-service-rsyncd "Rsync file matches test file using IPv4"


# Return if we don't have IPv6 support
if [ -z "$(ip -6 route show default)" ]; then
	fdc_test_alert mirror-service-rsyncd "Not running IPv6 tests due to no IPv6 default route"
	return
fi


fdc_test_start mirror-service-rsyncd "Testing Rsync connectivity using IPv6"
OUT_V6_873=$(socat -T2 - "TCP:[::1]:873,end-close" < /dev/null)
if ! grep 'RSYNC' <<< "$OUT_V6_873"; then
	fdc_test_fail mirror-service-rsyncd "Rsync connecitivty test using IPv6 failed"
	false
fi
fdc_test_pass mirror-service-rsyncd "Rsync connectivity over IPv6 working"


fdc_test_start mirror-service-rsyncd "Testing Rsync download using IPv6"
if ! rsync localhost::test/testfile6.txt /tmp/; then
	fdc_test_fail mirror-service-rsyncd "Rsync download test using IPv6 failed"
	false
fi
fdc_test_pass mirror-service-rsyncd "Rsync download using IPv6 working"


fdc_test_start mirror-service-rsyncd "Checking downloaded Rsync file matches test file using IPv6..."
if ! diff /data/testfile6.txt /tmp/testfile6.txt; then
	fdc_test_fail mirror-service-rsyncd "Downloaded file over Rsync does not match test file"
	false
fi
fdc_test_pass mirror-service-rsyncd "Rsync file matches test file using IPv6"
