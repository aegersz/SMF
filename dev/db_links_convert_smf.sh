#!/bin/bash
#
# rename internal links and restore the DB
#

# ADJUST THESE:
diff=-2
bdate=$(date '+%d-%m-%Y' -d "$diff hours")

live="forum.site-name.org/index.php/topic"
dev="192.168.0.180/index.php/topic"

echo 	converting all occurrences of $live to $dev ...
sed 	"s|$live|$dev|g" /forum/SQL/database_smf209_$bdate.sql > /forum/SQL/database_smf209_newlinks_$bdate.sql
echo 	"sed;"$?

