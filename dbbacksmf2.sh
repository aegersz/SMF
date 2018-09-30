#!/bin/bash

echo "writing" /SQL/database_smf209_$(date '+%d-%m-%Y_%H-%M-%S').sql "..."

mysqldump -uroot -pegerszegi smf209 > /SQL/database_smf209_$(date '+%d-%m-%Y_%H-%M-%S').sql

echo "Done !"

