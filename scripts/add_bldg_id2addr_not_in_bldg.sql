UPDATE bothell_addr SET bldg_id = b.gid FROM bothell_bldg b, bothell_parcel p, bothell_addr a
WHERE p.gid = a.parcel_gid AND b.parcel_gid = p.gid AND a.bldg_id IS NULL AND p.no_bldgs = 1 AND b.no_addr IS NULL;
