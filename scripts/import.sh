#!/bin/bash

WORKINGDIR=/home/clifford/Downloads/bothell_imports/scripts
PGDATABASE=mygis
PGUSER=postgres
SHP2PGSQL=`which shp2pgsql`
ORG2OGR=/home/clifford/bin/ogr2osm.py

cd ${WORKINGDIR}


# Import Precincts just once. We don't really care if they change.
if [ ! -f precincts.lst ]
then
	echo "Importing Precincts"
	psql ${PGDATABASE} -Atc "SELECT vtdst10 FROM bothell_votdst;" > precincts.lst
fi

# import Buildings 


echo "start configuring tables"


# This section adds fields to the new tables
psql -d ${PGDATABASE} -U ${PGUSER} -f add_columns.sql

psql -d ${PGDATABASE} -U ${PGUSER} -f add_indexes.sql
echo "complete configuring tables"

echo "clean up test runs"
psql -d ${PGDATABASE} -U ${PGUSER} -f clear_columns.sql

echo "Starting adding information to tables to speed execution later"
# Add full street name to address
psql -d ${PGDATABASE} -U ${PGUSER} -f add_full_street.sql

# add the parcel_cod to buildings completely inside of parcel
psql -d ${PGDATABASE} -U ${PGUSER} -f add_parcel_id2bldgs.sql
# This second query captures the buildings that lie just over a parcel boundary
psql -d ${PGDATABASE} -U ${PGUSER} -f add_parcelid2partial_bldg.sql


# Count the number of buildings in a parcel
psql -d ${PGDATABASE} -U ${PGUSER} -f no_bldgs2parcels.sql

# Add Building id to address
psql -d ${PGDATABASE} -U ${PGUSER} -f add_bldg_id2addr.sql
psql -d ${PGDATABASE} -U ${PGUSER} -f add_bldg_id2addr_not_in_bldg.sql


# Add count of addresses in buildings and parcels - slow query - 15 minutes on my workstation
psql -d ${PGDATABASE} -U ${PGUSER} -f add_no2bldg.sql
psql -d ${PGDATABASE} -U ${PGUSER} -f add_no2parcel.sql

# Create two views, one with all buildings and their addresses
# the other with just standalone addresses. These will be merged when creating the .osm import file.

psql -d ${PGDATABASE} -U ${PGUSER} -f bothell_ab.sql
psql -d ${PGDATABASE} -U ${PGUSER} -f bothell_ao.sql

echo "Done"
