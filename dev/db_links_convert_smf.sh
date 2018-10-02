#!/bin/bash

live="forum.site-name.org/index.php/topic"
dev="192.168.0.180/index.php/topic"

sed "s|$live|$dev|g" /rsync-live-dbbackup > /rsync-live-dbbackup-newlink
echo $?

