# Overview
Source files, translation scripts and OSM xml files for bothell import.

See [Import wiki](https://wiki.openstreetmap.org/wiki/Bothell_import) for overall plan.
 
## Files for import
osm folder contains files for import. The data is broken into files by voting
district.

## Translation
A mix of sql, bash and python were used translate, conflate and tag data.
All scripts used are in the scripts folder.  Requires bash shell, python, postgresql with postgis and ogr2ogr.

  - Set variables at top of import.sh and bothell_osm.sh to point to values for your
computer
  - Run import.sh
  - Run bothell_osm.sh
  - Output files will be in ./osm

## Source data
  - /Cadastre_shp/BothellAddress.* are source for addresses
  - /Buildings_shp/Buildings.* are source for buildings
