Projet Linux Admin N2 – TechNova
On a mis en place une infrastructure Linux avec 4 machines virtuelles sous Ubuntu 22.04.

Architecture
vm-admin    192.168.64.10    Administration

vm-dns      192.168.64.11    DNS

vm-web      192.168.64.12    Serveur Web

vm-mon      192.168.64.14    Supervision


Configuration réalisée
vm-admin

Création d'un RAID 1 avec mdadm.

Montage sur /srv/data.

Script de sauvegarde Bash.

Conservation des 5 dernières sauvegardes.

Automatisation avec Cron à 2h.


vm-dns

Installation de Bind9.

Création de la zone technova.lan.

Configuration des enregistrements DNS.

Tests de résolution entre les machines.


vm-web

Installation de Nginx.

Configuration de web.technova.lan.

Création d'une page HTML avec date et heure.

Mise en place du HTTPS avec certificat auto-signé.

Redirection HTTP vers HTTPS.


vm-mon

Installation de Cockpit.

Connexion des machines à l'interface de supervision.

Consultation des ressources et de l'état des services.


Sécurité
UFW activé sur les 4 machines.

Configuration des ports selon les services.

Connexion SSH root désactivée.


Captures d'écran
Les captures des différentes configurations et des tests sont toutes dans le dossier 
