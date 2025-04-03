#!/bin/bash

PROMETHEUS_POD=$(kubectl get pods --selector=app=prometheus -o jsonpath='{.items[0].metadata.name}')


echo "Mise en place du port forwarding pour Prometheus sur http://localhost:9090..."
kubectl port-forward "$PROMETHEUS_POD" 9090:9090 &


echo "Ouverture de la page web de Prometheus..."
xdg-open http://localhost:9090
