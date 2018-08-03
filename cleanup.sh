#!/bin/bash

export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)

# Persist Article Handler
kubeless trigger kafka delete broadcast-article 
kubeless function delete broadcast-article

# Get Article Handler
kubeless trigger http delete get-article
kubeless function delete get-article

# List Articles Handler
kubeless trigger http delete list-articles
kubeless function delete list-articles

# Persist Article Handler
kubeless trigger kafka delete persist-article 
kubeless topic delete new-article-topic
kubeless function delete persist-article

# Create Article Handler
kubeless trigger http delete create-article 
kubeless function delete create-article 

# Nginx Ingress
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml

# MongoDB
kubectl delete -f mongodb.yml

# Kafka
kubectl delete -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kafka-zookeeper-$RELEASE.yaml

# Kubeless
kubectl delete -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-non-rbac-$RELEASE.yaml
kubectl delete ns kubeless
