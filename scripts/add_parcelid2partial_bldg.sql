--create temp table no_parcel as select * from bothell_bldg b where parcel_gid is null;
UPDATE bothell_bldg b SET parcel_gid = p.gid 
FROM bothell_parcel p 
WHERE b.parcel_gid IS NULL and ST_INTERSECTS(b.geom,p.geom)
AND ST_AREA(ST_INTERSECTION(p.geom, b.geom)::geometry)/ST_AREA(b.geom::geometry) between .8 and .99999;
