#!/usr/bin/env bash

live="site-name.org"
dev="192.168.0.180"

sed "s|://'$live'/index.php/topic|://'$dev'/index.php/topic|g" /rsync-live-dbbackup > /rsync-live-dbbackup-newlinks

