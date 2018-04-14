update bothell_addr a set parcel_gid = p.gid from bothell_parcel p where st_contains(p.geom, a.geom)
