UPDATE bothell_parcel SET no_bldgs = subquery.count FROM ( SELECT p.gid, COUNT(*) AS count FROM bothell_bldg b,
bothell_parcel p WHERE p.gid = parcel_gid GROUP BY p.gid) AS subquery 
-- bothell_parcel p WHERE p.gid = b.gid GROUP BY p.gid) AS subquery 
WHERE subquery.gid IS NOT NULL AND bothell_parcel.gid = subquery.gid
