update bothell_parcel set no_bldgs = subquery.count from ( select p.gid, count(*) as count from bothell_bldg b,
bothell_parcel p where p.gid = b.gid group by p.gid) as subquery 
where subquery.gid is not null and bothell_parcel.gid = subquery.gid
