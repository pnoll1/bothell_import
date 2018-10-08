UPDATE bothell_addr a SET bldg_id = b.gid FROM bothell_bldg b WHERE ST_CONTAINS(b.geom, a.geom)
