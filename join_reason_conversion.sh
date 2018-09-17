#!/bin/bash

# This converts the old Join REason mod's data to the native Advanced Profile Fields

rm ~/jrf

dbuser="uuuu"
dbpass="pppp"
# Note: adjust "smf209" and "smf209_" to your actual DB and table prefixes

# Build a list of memeber id, name and join reason (if join reason isn't empty)

echo 	"USE 	smf209; 
	SELECT 	smf209_members.id_member, smf209_members.member_name, smf209_members.join_reason
	FROM 	smf209_members
	WHERE 	smf209_members.join_reason !='';" \
	| mysql -u$dbuser -p$dbpass > ~/jrf

# Read that list and initialize the new join reason (for verification)

count=0
while read a b; do
        let count=count+1
        if [ $count -gt 1 ]; then 
		echo 	"USE smf209;
			REPLACE INTO smf209_themes(variable, value, id_member)
			VALUES	(
				SUBSTRING('cust_joinre', 1, 255),
				SUBSTRING('unset yet', 1, 65534),
				$a
				);" \
			! mysql -u$dbuser -p$dbpass
        fi
done < ~/jrf

# Update the new join reason from the old

echo    "USE 	smf209;
	UPDATE 	smf209_themes
	JOIN    smf209_members 
	ON 	smf209_members.id_member=smf209_themes.id_member
	SET     smf209_themes.value = smf209_members.join_reason
	WHERE   smf209_themes.variable='cust_joinre' AND smf209_members.join_reason !='';" \
	| mysql -u$dbuser -p$dbpass

rm ~/jrf

