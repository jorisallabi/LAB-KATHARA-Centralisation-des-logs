chargement de simages dans docker 
#!/bin/bash

# Répertoire contenant les fichiers .tar
BACKUP_DIR="/media/joris/JojoD/monLAB"

# Charger toutes les images .tar dans Docker
for TAR_FILE in "$BACKUP_DIR"/*.tar; do
  docker load -i "$TAR_FILE"
done

echo "Toutes les images ont été chargées."
