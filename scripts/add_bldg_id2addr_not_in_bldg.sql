update bothell_addr a set bldg_id = b.gid from bothell_bldg b, bothell_parcel p
where a.gid =  b.gid and b.parcel_gid = p.gid and a.bldg_id is null and p.no_bldgs = 1 and b.no_addr is null
