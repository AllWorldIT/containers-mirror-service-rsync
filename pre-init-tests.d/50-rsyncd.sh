#!/bin/sh

apk add --no-cache socat

cat <<EOF > /etc/rsyncd.conf.d/test.conf
[test]
        path = /data
        comment = Test
EOF

echo "SUCCESS" > /data/testfile.txt

