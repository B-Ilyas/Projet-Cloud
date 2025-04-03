## Projet AutoScaling et IaC

### Introduction et prérequis

L’objectif de ce projet est de créer une infrastructure pour le projet redis-nodejs dans un cluster kubernetes. Pour observer le comportement des différents composants il faudra configurer un outil de monitoring: prometheus/grafana.
Avant de commencer le déploiement, assurez-vous d'avoir les outils suivants installés sur votre machine linux :

- Docker
- Kubernetes
- Minikube ou un cluster Kubernetes fonctionnel

### Architecture du projet

J'ai choisi de rendre l'architecture le plus simple possible en combinant la partie configuration du pod, du service du scaling de pour chaque fichiers de configuration yaml. J'ai aussi choisi par simplicité de garder tout les types de fichiers (script et config) dans le même répertoire. Aucun Dockerfile n'a été crée étant donné que l'on utilise kubernetes pour exploiter des images venant du docker hub. Vous devez donc trouver : 4 fichiers de script bash et 5 fichiers de configuration yaml.

P1  
├── clean.sh  
├── deploy.sh  
├── grafana.yml  
├── grafana.sh  
├── prometheus.yml  
├── prometheus.sh  
├── Rapport-P1.pdf  
├── README.md  
├── redis.yml  
├── redis-node.yml  
├── redis-react.yml  


### Initialisation

Suivre les étapes pour préparer l'environnement de déploiement :

1. **Démarrage de Minikube et Activation du Tunnel**

   Lancer Minikube et activer le tunnel pour permettre la communication :
   ```bash
   minikube start
   minikube tunnel
   ```

2. **Préparation des Scripts**

   Ouvrir un autre terminal et s'assurer que les scripts bash (`deploy.sh`, `clean.sh`, `grafana.sh`, `prometheus.sh`) ont les permissions nécessaires pour s'exécuter :
   ```bash
   chmod +x *.sh
   ```

### Phase de Tests

Pour déployer et tester les services, procéder comme suit :

1. **Déploiement**

   Exécuter le script `deploy.sh` pour lancer le déploiement :
   ```bash
   ./deploy.sh
   ```
	Ce script une fois executé applique la configuration de tout les fichiers YAML avec kubectl apply. Le script continue d'exécuter le port forwarding de prometheus en arrière-plan. 


2. **Vérification de l'État des Services**

   Dans ce même terminal, vérifier que tous les pods, services et replicas soient déployés et fonctionnels avec la commande : 
   ```bash
   kubectl get all
   ```

3. **Ouverture de Prometheus**

   Pour accéder à Prometheus, exécuter le script associé:
   ```bash
   ./prometheus.sh
   ```
   Ce script trouve le premier pod Prometheus disponible, forward le port 9090 du pod Prometheus vers le port 9090 local et ouvre la page web de Prometheus.


4. **Accès à Grafana**

   Ouvrir un 3ème terminal pour ouvrir l'interface Grafana et lancer la commande :
   ```bash
   ./grafana.sh
   ```
   - **Identifiants** : Utiliser `admin` comme nom d'utilisateur et `1234` comme mot de passe.
   - **Configuration de la Source de Données** : Aller dans la rubrique "Data Source" du site. Si Prometheus est correctement connecté, le déploiement est donc opérationnel.
   - **Création d'un Tableau de Bord** : Cliquer sur "+" pour ajouter un tableau de bord. Tester une fonctionnalité en interagissant avec un service lié à Prometheus.

5. **Nettoyage**

   Enfin, pour terminer le déploiement et nettoyer l'environnement, exécuter le script `delete.sh` :
   ```bash
   ./clean.sh
   ```
Ce script une fois executé supprime toutes les ressources Kubernetes du cluster déployé via la commande kubectl delete, puis trouve et termine le processus lié au port forwarding pour Prometheus.
