DATE_WITH_TIME=`date "+%Y%m%d-%H%M%S"`
BACKUP_FILE_NAME="$DATE_WITH_TIME"_daily.psql
docker exec postgres pg_dump -U user -f /backup/$BACKUP_FILE_NAME
s3cmd put -c /etc/s3conf/s3conf.cfg -r -s -v {{ common_postgres_backup_target }}/$BACKUP_FILE_NAME s3://ioverlander-backup-test/pg_backup_daily/ > /var/log/s3sync

