#
# mirror live web system to the intranet
#

#diff=-2 (to sync with SGP)
diff=-2

bdate=$(date '+%d-%m-%Y' -d "$diff hours")
btime=$(date '+%d-%m-%Y_%H-%M-%S' -d "$diff hours")

echo    Copy database_smf209_$bdate.sql ...
rsync   -zpaAPve ssh root@forum.drugs-and-users.org:/SQL/database_smf209_$bdate.sql \
		/rsync-live-dbbackup                
#		/forum/SQL/
echo
echo    Archive to database_smf209_$btime.sql ...
rsync   -paAPv /rsync-live-dbbackup /forum/SQL/database_smf209_$btime.sql
echo

if  [ "$1"  ==  "y" ]; then
	echo    Copy and archive database_allDBs_$bdate.sql ...
	rsync   -zpaAPve ssh root@forum.drugs-and-users.org:/SQL/database_allDBs_$bdate.sql \
	                /forum/SQL/database_allDBs_$bdate.sql
	echo
fi

echo " "
echo "DB Restore in progress (takes a minute or two) ..."
echo " "

#mysql -u root -proot smf209 < /rsync-live-dbbackup

sh db_links_convert_smf.sh

pv /rsync-live-dbbackup-newlinks | mysql -u root -proot smf209
#pv /rsync-live-dbbackup | mysql -u root -proot smf209

echo "Done !"
echo ""
echo " >>> run repair_settings.php after EVERY db restore !"

