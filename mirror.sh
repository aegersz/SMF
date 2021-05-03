# mirror live web system to the intranet

# rsync-live-html-with-delete
echo "Live HTML directories are now being copied (special) ..."
rsync -zpaAXPve ssh --delete --exclude-from=/data/exclusions-special root@forum.drugs-and-users.org:/var/www/html/ /rsync-live-html-with-delete/
echo 

# rsync-live-html
echo "Live HTML directories are now being copied (normal) ..."
rsync -zpaAXPve ssh --exclude-from=/data/exclusions /rsync-live-html-with-delete/ /var/www/html/
rsync -zpaAXPve ssh --exclude-from=/data/exclusions root@forum.drugs-and-users.org:/var/www/html/ /var/www/html/
echo
scp forum:/var/www/html/private/index.html /var/www/html/private/
echo

# rsync-live-html-unique
echo "Unique HTML files are now being copied ..."
rsync -zpaAXPve ssh --include-from=/data/inclusions --exclude="*" root@forum.drugs-and-users.org:/var/www/html/  \
	/rsync-live-html-unique/
echo
#rsync -zpaAXPve ssh root@forum.drugs-and-users.org:/var/www/html/owncloud/config/config.php \
#	/rsync-live-html-unique/
#echo

# rsync data
rsync -zpaAXPve ssh root@forum.drugs-and-users.org:/data/ /forum/data/

# fix ownership
chown 	-R apache:apache /var/www/html
echo

#dblivesmf
#
sh 	dblivesmf.sh y
#       ------------ n <-- backup allDB ? (y/n)

#Remove old SQL backups
sh SQLhousekeeping

#getlives
rsync-live-root
echo
rsync-live-bin
echo
rsync-live-etc
echo
rsync-live-git
echo 
#
echo Finished !
#
# CHECK ME OCCASIONALLY -> SQLhousekeeping ???

# getmore occasionally

rsync -zpaAXPve ssh forum:/tips/ /tips/
rsync -zpaAXPve ssh forum:/cpp/ /cpp/
rsync -zpaAXPve ssh forum:/perl/ /perl/
rsync -zpaAXPve ssh root@forum.drugs-and-users.org:/home/automailer/ /forum/automailer/
#rsync -zpaAXPve ssh root@forum.drugs-and-users.org:/home/ /forum/home/
#rsync -zpaAXPve ssh root@forum.drugs-and-users.org:/tmp/backup-config-manifests/ /forum/
#rsync -zpaAXPve ssh root@forum.drugs-and-users.org:/boot/ /forum/boot/
#rsync -zpaAXPve ssh root@forum.drugs-and-users.org:/var/log/ /forum/var/log/
#rsync -zpaAXPve ssh root@forum.drugs-and-users.org:/etc/ /home/forum/etc/
 
