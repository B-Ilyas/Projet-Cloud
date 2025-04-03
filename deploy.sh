#!/bin/bash

kubectl apply -f prometheus.yml
kubectl apply -f redis.yml
kubectl apply -f redis-node.yml
kubectl apply -f redis-react.yml
kubectl apply -f grafana.yml
kubectl rollout restart deployment grafana-deployment

echo "Déploiement effectué avec succès."

