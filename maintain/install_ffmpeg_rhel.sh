#!/bin/bash
curl https://raw.githubusercontent.com/yuanbluemood/webop/master/maintain/dag.repo -o /etc/yum.repos.d/dag.repo
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt;
yum -y install ffmpeg ffmpeg-devel;
