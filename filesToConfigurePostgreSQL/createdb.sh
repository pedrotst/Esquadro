#!/bin/bash

#################################################
#
# This script needs be executed without user root,
# because by default, postgresql have an role
# named 'postgres' that have permission to create
# and alter databases.
#
#################################################


# Default user is postgres
echo "Creating source info database..."

POSTGRES_USER="postgres"

createdb -O $POSTGRES_USER source_info
echo "Success!"

# Creating tables needed
psql source_info -a -f createTables.sql
