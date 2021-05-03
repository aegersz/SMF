#!/bin/bash

live="forum.drugs-and-users.org/index.php/topic"
dev="192.168.0.180/index.php/topic"

echo    Coverting all occurrences of $live to $dev ...
sed     "s|$live|$dev|g" /rsync-live-dbbackup > /rsync-live-dbbackup-newlinks
echo    "sed;"$?
echo

live="128.199.200.202"
dev="192.168.0.180"
echo    Coverting all occurrences of $live to $dev ...
sed -i  "s|$live|$dev|g" /rsync-live-dbbackup-newlinks
echo    "sed;"$?
echo

live="128.199.200.202"
dev="192.168.0.180"
echo    Coverting all occurrences of $live/private to $dev ...
sed -i  "s|$live|$dev|g" /var/www/html/private/index.html
echo    "sed;"$?
echo

live="128.199.200.202"
dev="192.168.0.180"
echo    Coverting all occurrences of $live/private5 to $dev ...
sed -i  "s|$live|$dev|g" /var/www/html/private5/index.html
echo    "sed;"$?
echo

