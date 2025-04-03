#!/bin/bash

GRAFANA_URL=$(kubectl get svc grafana-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
if [ -z "$GRAFANA_URL" ]; then
    GRAFANA_URL=$(kubectl get svc grafana-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
fi

if [ ! -z "$GRAFANA_URL" ]; then
    echo "Grafana est accessible à http://$GRAFANA_URL:3000"
    echo "Ouverture de la page web de Grafana..."
    xdg-open "http://$GRAFANA_URL:3000"
else
    echo "Le service Grafana n'existe pas ou n'utilise pas de LoadBalancer. Vérifiez le type de service et son nom."
fi

