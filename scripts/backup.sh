#!/bin/sh

SOURCE_DIR="/config"
BACKUP_DIR="/backups"

RETENTION_DAYS=${RETENTION_DAYS:-30}
ENVIRONMENT=${ENVIRONMENT:-unknown}

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILENAME="dokuwiki-${ENVIRONMENT}-${TIMESTAMP}.tar.gz"
BACKUP_FILE_PATH="${BACKUP_DIR}/${BACKUP_FILENAME}"

echo "--- $(date) ---"
echo "Starting backup of ${SOURCE_DIR} to ${BACKUP_FILE_PATH} (Environment: ${ENVIRONMENT})..."

tar -czf "${BACKUP_FILE_PATH}" -C / "$(basename "${SOURCE_DIR}")"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully: ${BACKUP_FILENAME}"
else
    echo "ERROR: Backup failed!"
    exit 1
fi

echo "Removing backups older than ${RETENTION_DAYS} days in ${BACKUP_DIR}..."
find "${BACKUP_DIR}" -name "dokuwiki-${ENVIRONMENT}-*.tar.gz" -mtime +"${RETENTION_DAYS}" -delete
echo "Cleanup completed."
echo "-------------------"

exit 0