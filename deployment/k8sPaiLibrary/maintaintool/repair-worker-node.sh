#!/bin/bash

# Copyright (c) Microsoft Corporation
# All rights reserved.
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
# to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

docker stop kubelet
docker rm kubelet

for id in `docker ps -a | awk "/k8s_/ {print\\$1}"`
do
    docker kill ${id}
    docker rm ${id}
done

etcd_yaml="/etc/kubernetes/manifests/etcd.yaml"
if [[ -f ${etcd_yaml} ]]; then
    echo  Error: This is a infra node. The repair tool will exit.
    exit 1
fi

# check etc/ exist or not.
static_pod="repair/etc"
if [[ -d ${static_pod} ]]; then
    cp -r ${static_pod} /
fi

chmod u+x repair/kubelet.sh && ./repair/kubelet.sh



