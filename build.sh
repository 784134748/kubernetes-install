#!/usr/bin/env bash

#CMD1、生成配置文件
./paictl.py config generate -i ./deployment/quick-start/quick-start.yaml -o ./deployment/quick-start/pai-config -f

#更新cluster配置
./paictl.py config push -c ~/.kube/config -p ./deployment/quick-start/pai-config

#CMD2、安装k8s
./paictl.py cluster k8s-bootup -p ./deployment/quick-start/pai-config

#CMD3、发布组件 ['drivers', 'cluster-configuration', 'pylon', 'hadoop-data-node', 'alert-manager', 'hadoop-jobhistory', 'end-to-end-test', 'grafana', 'zookeeper', 'hadoop-name-node', 'job-exporter', 'watchdog', 'rest-server', 'hadoop-batch-job', 'hadoop-node-manager', 'webportal', 'prometheus', 'yarn-frameworklauncher', 'cleaner', 'node-exporter', 'hadoop-resource-manager']
./paictl.py service start -c ~/.kube/config -n drivers