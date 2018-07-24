drop table if exists temp_addr;
create temporary table temp_addr as select distinct a.gid from bothell_addr a, bothell_addr b where st_equals(a.geom,b.geom) and a.gid <> b.gid order by a.gid;
update bothell_addr set dup = true from temp_addr where bothell_addr.gid = temp_addr.gid