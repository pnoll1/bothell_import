DROP VIEW bothell_ao;

CREATE OR REPLACE VIEW  bothell_ao AS(
SELECT gid, addr_num, unit, streetname, INITCAP(postalcity) AS city, zip, geom 
FROM bothell_addr WHERE bldg_id IS NULL and dup is NULL
UNION
SELECT gid, addr_num, ''::VARCHAR as unit, streetname, INITCAP(postalcity) AS city, zip, geom 
FROM bothell_addr WHERE bldg_id IS NULL and dup is true
UNION
SELECT a.gid, addr_num, unit ,streetname, INITCAP(postalcity) AS city, zip, a.geom
FROM bothell_addr a, bothell_bldg b
WHERE bldg_id = b.gid AND no_addr > 1 and dup is NULL
UNION
SELECT a.gid, addr_num, ''::VARCHAR unit ,streetname, INITCAP(postalcity) AS city, zip, a.geom
FROM bothell_addr a, bothell_bldg b
WHERE bldg_id = b.gid AND no_addr > 1 and dup is true);

ALTER TABLE bothell_ao
	OWNER TO clifford;
