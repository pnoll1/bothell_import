update bothell_addr a set bldg_id = b.gid from bothell_bldg b where st_contains(b.geom, a.geom)
