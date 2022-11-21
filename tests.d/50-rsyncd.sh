#!/bin/bash

echo "TESTS: Rsyncd connectivity..."
OUT_V4_873=$(socat -T2 - "TCP:127.0.0.1:873,end-close" < /dev/null)
if ! grep 'RSYNC' <<< "$OUT_V4_873"; then
	echo "CHECK FAILED (rsyncd): Check IPv4 port 873 works"
	false
fi

echo "TESTS: Rsyncd works..."
if ! rsync localhost::test/testfile.txt /tmp/; then
	echo "CHECK FAILED (rsync): Rsync from server failed"
	false
fi

echo "TESTS: Rsync'd file matches..."
if ! diff /data/testfile.txt /tmp/testfile.txt; then
	echo "CHECK FAILED (rsync): Data contained in 'testfile.txt' does not match what it should"
	false
fi

