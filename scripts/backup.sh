#!/bin/bash
# backup.sh - Archive /etc, /home, /var/www vers /srv/data/backups
# Garde les 5 archives les plus récentes

BACKUP_DIR="/srv/data/backups"
LOG_FILE="/var/log/backup.log"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
    logger -t backup "$1"
}

mkdir -p "$BACKUP_DIR"
log "Début de la sauvegarde"

# /var/www peut ne pas exister sur vm-admin : on ne garde que les dossiers présents
SOURCES=""
for dir in /etc /home /var/www; do
    [ -d "$dir" ] && SOURCES="$SOURCES $dir"
done

if tar -czf "$ARCHIVE" $SOURCES 2>/dev/null; then
    log "Archive créée : $ARCHIVE ($(du -h "$ARCHIVE" | cut -f1))"
else
    log "ERREUR : échec de la création de l'archive"
    exit 1
fi

# Rotation : on garde les 5 plus récentes
ls -1t "$BACKUP_DIR"/backup_*.tar.gz | tail -n +6 | while read old; do
    rm -f "$old"
    log "Ancienne archive supprimée : $old"
done

log "Sauvegarde terminée"
