#!/bin/bash

BACKUP_DIR="/path/to/backups"
WORLD_DIR="/path/to/world"
MAX_DISK_USAGE=70

NOW=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/world_backup_$NOW.tar.gz" -C "$WORLD_DIR" .

USAGE=$(df --output=pcent / | tail -n 1 | tr -dc '0-9')

while [ "$USAGE" -ge "$MAX_DISK_USAGE" ]; do
    echo "디스크 사용량 ${USAGE}% > ${MAX_DISK_USAGE}%, 오래된 백업 삭제 중..."
    OLDEST_BACKUP=$(ls -1 "$BACKUP_DIR" | sort | head -n 1)
    rm -f "$BACKUP_DIR/$OLDEST_BACKUP"
    sleep 1
    USAGE=$(df --output=pcent / | tail -n 1 | tr -dc '0-9')
done

echo "백업 완료. 현재 디스크 사용량: ${USAGE}%"