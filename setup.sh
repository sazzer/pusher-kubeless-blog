#!/bin/bash

export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)

# Set up Kubeless
kubectl create ns kubeless
kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-non-rbac-$RELEASE.yaml

# Set up Kafka
kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kafka-zookeeper-$RELEASE.yaml

# Set up MongoDB
kubectl create -f mongodb.yml

# Set up Nginx Ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/bc59b7ddeee6e252974853f167c299005c600781/deploy/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/bc59b7ddeee6e252974853f167c299005c600781/deploy/provider/cloud-generic.yaml

# Create Article endpoint
kubeless function deploy create-article --runtime nodejs8 --dependencies create-article/package.json --handler index.createArticle --from-file create-article/index.js
sleep 5
kubeless trigger http create create-article --function-name create-article --path create --hostname localhost
# curl -v http://localhost/create

# Persist Article handler
kubeless topic create new-article-topic
kubeless function deploy persist-article --runtime nodejs8 --dependencies persist-article/package.json --handler index.persistArticle --from-file persist-article/index.js
sleep 5
kubeless trigger kafka create persist-article --function-selector created-by=kubeless,function=persist-article --trigger-topic new-article-topic

# List Articles endpoint
kubeless function deploy list-articles --runtime nodejs8 --dependencies list-articles/package.json --handler index.listArticles --from-file list-articles/index.js
sleep 5
kubeless trigger http create list-articles --function-name list-articles --path list --hostname localhost
# curl -v http://localhost/list

# Get Article endpoint
kubeless function deploy get-article --runtime nodejs8 --dependencies get-article/package.json --handler index.getArticle --from-file get-article/index.js
sleep 5
kubeless trigger http create get-article --function-name get-article --path get --hostname localhost
# curl -v http://localhost/get
