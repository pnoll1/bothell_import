#!/bin/bash

WORKINGDIR=/home/clifford/Downloads/bothell_import/scripts
OGR2OSM=/home/clifford/bin/ogr2osm.py
PGUSER=postgres
PGDATABASE=mygis

cd ${WORKINGDIR}

if [ ! -d ${WORKINGDIR}/osm/ ]
then
	mkdir ${WORKINGDIR}/osm/ 
fi
	
if [ ! -d ${WORKINGDIR}/tmp/ ]
then
	mkdir ${WORKINGDIR}/tmp/ 
fi
	
while read line
do
    id=`echo $line |awk '{print $1}'`

    if [ -e ${WORKINGDIR}/tmp/${id}a.shp ]
    then
      echo "Removing old files"
      rm ${WORKINGDIR}/tmp/${id}a.shp
      rm ${WORKINGDIR}/tmp/${id}a.shx
      rm ${WORKINGDIR}/tmp/${id}a.prj
      rm ${WORKINGDIR}/tmp/${id}a.dbf
      rm ${WORKINGDIR}/tmp/${id}a.osm
      rm ${WORKINGDIR}/tmp/${id}b.shp
      rm ${WORKINGDIR}/tmp/${id}b.shx
      rm ${WORKINGDIR}/tmp/${id}b.prj
      rm ${WORKINGDIR}/tmp/${id}b.dbf
      rm ${WORKINGDIR}/tmp/${id}b.osm
    fi

    if [ -e ${WORKINGDIR}/osm/${id}.osm.gz ]
    then
      rm ${WORKINGDIR}/osm/${id}.osm.gz
    fi

    echo "creating shapefiles for vtdst10 = ${id}"
    pgsql2shp -f ${WORKINGDIR}/tmp/${id}b -h localhost -u ${PGUSER} ${PGDATABASE} "SELECT b.* FROM bothell_ba b, bothell_votdst p WHERE ST_CONTAINS(p.geom, st_centroid(b.geom)) AND vtdst10 = '${id}' and reason(st_isvaliddetail(b.geom)) is null"
    if [ -f ${WORKINGDIR}/tmp/${id}b.shp ]
    then
    	echo "${OGR2OSM} -f -t ${WORKINGDIR}/bothell_bldg.py ${WORKINGDIR}/tmp/${id}b.shp -o ${WORKINGDIR}/tmp/${id}b.osm"
    	${OGR2OSM} -f -t ${WORKINGDIR}/bothell_bldg.py ${WORKINGDIR}/tmp/${id}b.shp -o ${WORKINGDIR}/tmp/${id}b.osm
    fi

    pgsql2shp -f ${WORKINGDIR}/tmp/${id}a -h localhost -u ${PGUSER} ${PGDATABASE} "SELECT a.* FROM bothell_ao a, bothell_votdst p WHERE ST_CONTAINS(p.geom, a.geom) AND vtdst10  = '${id}'"
    if [ -f ${WORKINGDIR}/tmp/${id}a.shp ] 
    then
    	echo "${OGR2OSM} -f -t ${WORKINGDIR}/bothell_addr.py ${WORKINGDIR}/tmp/${id}a.shp -o ${WORKINGDIR}/tmp/${id}a.osm"
    	${OGR2OSM} -f -t ${WORKINGDIR}/bothell_addr.py ${WORKINGDIR}/tmp/${id}a.shp -o ${WORKINGDIR}/tmp/${id}a.osm
    fi

    if [ -f ${WORKINGDIR}/tmp/${id}b.shp ] 
    then
        python ${WORKINGDIR}/merge_osm2.py ${WORKINGDIR}/tmp/${id}b.osm ${WORKINGDIR}/tmp/${id}a.osm ${WORKINGDIR}/osm/${id}.osm
    else
	echo "mv ${WORKINGDIR}/tmp/${id}a.osm ${id}.osm"
	mv ${WORKINGDIR}/tmp/${id}a.osm ${WORKINGDIR}/osm/${id}.osm
    fi

    if [ -f ${WORKINGDIR}/tmp/${id}.osm ] 
    then
    	mv ${id}.osm ${WORKINGDIR}/osm
    fi

    gzip ${WORKINGDIR}/osm/${id}.osm
done < precincts.lst
