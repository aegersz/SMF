#!/bin/bash

# yum install pipe viewer (pv) first

pv /SQL/database_smf209_DD-MM-YYYY_HH-MM-SS.sql | mysql -udbusert -pdbpass smf209
