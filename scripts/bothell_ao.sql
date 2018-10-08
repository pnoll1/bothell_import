DROP VIEW bothell_ao;

CREATE OR REPLACE VIEW  bothell_ao AS(
SELECT gid, addr_num, unit, streetname, INITCAP(postalcity) AS city, zip, geom 
FROM bothell_addr WHERE bldg_id IS NULL
UNION
SELECT a.gid, addr_num, NULL as unit ,streetname, INITCAP(postalcity) AS city, zip, a.geom
FROM bothell_addr a, bothell_bldg b
WHERE bldg_id = b.gid AND no_addr > 1 and bldg_type in ('Multi Family','Commercial'));

ALTER TABLE bothell_ao
	OWNER TO clifford;
