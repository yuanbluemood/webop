#!/bin/bash
cat >/etc/yum.repos.d/dag.repo <<EOF
[dag]
name=Dag RPM Repository for Red Hat Enterprise Linux
baseurl=http://apt.sw.be/redhat/el\$releasever/en/\$basearch/dag
gpgcheck=1
enabled=1
EOF

rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt;
yum -y install ffmpeg ffmpeg-devel;
