# Unload the current database
mysqldump -udbuser -pdbpass smf209 > /SQL/database_smf209_`date '+%d-%m-%Y'`.sql
echo
echo Convert the table prefix to the clone
# Convert the table prefix to the clone
sed 's/`smf209_/`smfclone1_/g' /SQL/database_smf209_`date '+%d-%m-%Y'`.sql > /SQL/smfclone1.sql
echo
echo Drop and Recreate the clone database
# Drop and Recreate the clone database
mysql -udbuser -pdbpass < /root/data/mysql.batch
echo
echo Reload the clone database
# Reload the clone database
mysql -udbuser -pdbpass smfclone1 < /SQL/smfclone1.sql
echo
echo Fix up Settings.php and set into Maintenance Mode
# Fix up Settings.php and set into Maintenance Mode
cp /var/www/html/smfnew/Settings.php-maint-mode /var/www/html/smfnew/Settings.php
echo
echo Disable repair_settings (just in case)
mv /var/www/html/smfnew/repair_settings.php /var/www/html/smfnew/repair_settings.php-orig
