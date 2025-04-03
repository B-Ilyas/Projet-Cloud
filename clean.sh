#!/bin/bash

kubectl delete -f prometheus.yml
kubectl delete -f redis.yml
kubectl delete -f redis-node.yml
kubectl delete -f redis-react.yml
kubectl delete -f grafana.yml

echo "Suppression effectuée avec succès."

echo "Terminaison du port forwarding pour Prometheus..."
PROMETHEUS_FORWARD_PID=$(ps aux | grep 'kubectl port-forward' | grep '9090:9090' | awk '{print $2}' | head -n 1)

if [ ! -z "$PROMETHEUS_FORWARD_PID" ]; then
    kill $PROMETHEUS_FORWARD_PID
    echo "Port forwarding terminé."
else
    echo "Aucun processus de port forwarding pour Prometheus trouvé."
fi

