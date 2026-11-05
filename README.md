# Projet Linux Admin N2 – Infrastructure TechNova

Déploiement d'une infrastructure résiliente, sécurisée et supervisée sous Ubuntu 22.04 LTS.

## 📌 Architecture & Adressage Réseau

| Machine | Rôle | IP Statique | Services déployés |
| :--- | :--- | :--- | :--- |
| **vm-admin** | Administration | 192.168.64.10 | RAID 1 (`mdadm`), Backup automatique, Cron, Cockpit client |
| **vm-dns** | Serveur DNS | 192.168.64.11 | Bind9 (Zone `technova.lan`), Cockpit client |
| **vm-web** | Serveur Web | 192.168.64.12 | Nginx, HTTPS (SSL auto-signé), Redirection 301, Cockpit client |
| **vm-mon** | Supervision | 192.168.64.14 | Cockpit Dashboard centralisé (port 9090) |

---

## 🛠️ Composants Déployés

### 1. Stockage & RAID 1 (`vm-admin`)
* Volume RAID 1 logiciel avec `mdadm` (`/dev/md0`) composé de `/dev/vdb` et `/dev/vdc`.
* Formaté en `ext4` et monté de façon persistante sur `/srv/data` via `/etc/fstab`.

### 2. Automatisation des Sauvegardes
* Script `/usr/local/bin/backup.sh` sauvegardant `/etc`, `/home`, et `/var/www` vers `/srv/data/backups`.
* Rétention automatique des **5 archives les plus récentes**.
* Planification via Crontab quotidiennement à 2h00 (`0 2 * * *`).

### 3. DNS Interne (`vm-dns`)
* Bind9 configuré avec la zone locale `technova.lan`.
* Enregistrements A et résolution validés pour toutes les VMs.

### 4. Serveur Web Sécurisé (`vm-web`)
* Nginx configuré avec VirtualHost `web.technova.lan`.
* Certificat SSL auto-signé généré avec OpenSSL.
* Redirection HTTP (80) -> HTTPS (443).
* Page web dynamique avec horloge JavaScript en direct.

### 5. Supervision (`vm-mon`)
* Dashboard Cockpit actif sur le port 9090.
* Les 4 VMs sont reliées et supervisées en temps réel.

### 6. Sécurité & Pare-feu (Toutes VMs)
* Désactivation du login SSH Root (`PermitRootLogin no`).
* UFW actif en `default deny incoming` et `default allow outgoing`.
* Ports filtrés selon les rôles : 22, 53, 80, 443, 9090.

---

## 📸 Captures d'écran
Toutes les preuves d'exécution (UFW, Nginx, Cockpit, panne et reconstruction RAID) se trouvent dans le dossier `/screenshots`.
