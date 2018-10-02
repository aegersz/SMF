#!/bin/bash

live="forum.site-name.org/index.php/topic"
dev="192.168.0.180/index.php/topic"

echo coverting all occurrences of $live to $dev ...
sed "s|$live|$dev|g" /rsync-live-dbbackup > /rsync-live-dbbackup-newlinks
echo "sed;"$?

