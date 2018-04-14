UPDATE bothell_bldg SET no_addr = subquery.count FROM (SELECT b.gid,COUNT(*) AS count FROM bothell_addr a, bothell_bldg b
WHERE ST_CONTAINS(b.geom, a.geom) GROUP BY b.gid) AS subquery WHERE subquery.gid IS NOT NULL AND bothell_bldg.gid = subquery.gid
