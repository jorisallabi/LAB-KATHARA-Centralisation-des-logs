#!/bin/bash

# Répertoire de sauvegarde des images
BACKUP_DIR="/media/joris/JojoD/monLAB"
mkdir -p "$BACKUP_DIR"

# Récupérer les IDs des conteneurs actifs
CONTAINER_IDS=$(docker ps -q)

# Vérifier s'il y a des conteneurs actifs
if [ -z "$CONTAINER_IDS" ]; then
  echo "Aucun conteneur actif trouvé."
  exit 0
fi

# Boucle à travers chaque conteneur
for CONTAINER_ID in $CONTAINER_IDS; do
  # Récupérer le nom du conteneur
  CONTAINER_NAME=$(docker inspect --format='{{.Name}}' $CONTAINER_ID | sed 's/^\///')
  
  # Convertir le nom du conteneur en minuscules
  LOWER_CASE_NAME=$(echo "$CONTAINER_NAME" | tr '[:upper:]' '[:lower:]')
  
  # Définir le nom de l'image de sauvegarde
  IMAGE_NAME="${LOWER_CASE_NAME}_backup:latest"
  
  # Créer une image à partir du conteneur
  docker commit $CONTAINER_ID $IMAGE_NAME
  
  # Sauvegarder l'image dans le répertoire de sauvegarde
  docker save -o "$BACKUP_DIR/${LOWER_CASE_NAME}_backup.tar" $IMAGE_NAME
  
  # Afficher un message de succès
  echo "Conteneur $CONTAINER_NAME sauvegardé sous l'image $IMAGE_NAME."
done

echo "Sauvegarde de tous les conteneurs actifs terminée."

