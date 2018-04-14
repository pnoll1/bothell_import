UPDATE bothell_parcel SET no_addr = subquery.count FROM (SELECT p.gid,COUNT(*) AS count FROM bothell_addr a, bothell_parcel p
WHERE ST_CONTAINS(p.geom, a.geom) GROUP BY p.gid) AS subquery WHERE subquery.gid IS NOT NULL AND bothell_parcel.gid = subquery.gid
