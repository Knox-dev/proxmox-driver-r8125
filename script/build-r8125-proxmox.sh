#!/bin/bash



# Désactivation du dépôt entreprise
sed -i 's/^deb/#deb/g' /etc/apt/sources.list.d/pve-enterprise.list

# Ajout du dépôt No-Subscription (Bookworm)
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" >> /etc/apt/sources.list
apt update


# Installation des outils de compilations et des headers correspondant au noyau courrant:
apt install -y pve-headers-$(uname -r) build-essential dkms

# Apres avoir télécharger le driver sur le site de Realtek:
tar axvf r8125-9.016.01.tar.*
cd r8125-9.016.01

# a cette étape, autorun va utiliser DKMS afin de s'assurer que le driver r8125 soit recompilé 
# au démarrage en cas de mise à jour du kernel Linux
bash autorun.sh

# on charge le module r8125 

modprobe r8125