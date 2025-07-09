#!/bin/sh

BACKUP_SCRIPT="/app/backup.sh"
BACKUP_FREQ_MINUTES=${BACKUP_FREQ:-240}
BACKUP_FREQ_SECONDS=$((BACKUP_FREQ_MINUTES * 60))

echo "--- $(date) --- Backup loop started ---"
echo "Running backup script every ${BACKUP_FREQ_MINUTES} minutes (${BACKUP_FREQ_SECONDS} seconds)..."

while true; do
    "${BACKUP_SCRIPT}" >> /proc/self/fd/1 2>&1
    echo "--- $(date) --- Backup cycle finished, waiting ${BACKUP_FREQ_MINUTES} minutes before next run ---"
    sleep "${BACKUP_FREQ_SECONDS}"
done
