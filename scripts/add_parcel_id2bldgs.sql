update bothell_bldg b set parcel_gid = p.gid from bothell_parcel p where st_contains(p.geom, b.geom)
