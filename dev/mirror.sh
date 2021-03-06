#!/usr/bin/env bash

#
# mirror live web system (SGT zone) to the intranet (AEST zone)
#

# ADJUST TIME OFFSET FOR DST !
diff=-2

bdate=$(date '+%d-%m-%Y' -d "$diff hours")
btime=$(date '+%d-%m-%Y_%H-%M-%S' -d "$diff hours")

echo
echo    Copy html directories as is ...
rsync   -zpaAPve ssh --delete --exclude-from=/data/exclusions-special root@site-name.org:/var/www/html/ /forum/html_special/
echo
echo    Merge html directories ...
rsync   -zpaAPve ssh --exclude-from=/data/exclusions root@site-name.org:/var/www/html/ /forum/html/
chown   -R apache:apache /var/www/html
echo
echo    Copy html directories locally ...
rsync   -paAPv 	/forum/html/ /var/www/html/
echo
echo    Copy database_smf209_$bdate.sql ...
rsync   -zpaAPve ssh root@site-name.org:/SQL/database_smf209_$bdate.sql \
                /forum/SQL/
echo
echo    Archive database_smf209_$bdate.sql to database_smf209_$btime.sql ...
rsync   -paAPv 	/forum/SQL/database_smf209_$bdate.sql \
            	/forum/SQL/database_smf209_$btime.sql
echo
echo	Rename the internal links ...
sh 	/bin/db_links_convert_smf.sh
echo
echo    Restore the database ...
pv 	/forum/SQL/database_smf209_newlinks_$bdate.sql | mysql -udbuser -pdbpass smf209
echo
echo    "Run repair_settings.php ASAP !"
echo
echo    Copy the SMF unique files ...
rsync   -zpaAPve ssh --include-from=/data/inclusions --exclude="*" root@site-name.org:/var/www/html/ /forum/html_unique/
echo
echo    Copy the SQL unique files ...
rsync   -zpaAPve ssh root@site-name.org:/SQL/db*.sql /forum/SQL/

echo
echo "done !"
