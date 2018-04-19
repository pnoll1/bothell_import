DROP VIEW bothell_ba;
CREATE OR REPLACE VIEW bothell_ba AS(
SELECT a.gid as aid, b.gid as bid,addr_num, unit, streetname, 
	zip, INITCAP(postalcity) AS city, b.name,
	bldg_type, ROUND(height_est * .3048,1) AS height, no_addr, b.geom 
FROM bothell_addr a, bothell_bldg b
WHERE b.gid=bldg_id AND no_addr = 1 and dup is NULL
UNION
SELECT a.gid as aid, b.gid as bid,addr_num, ''::VARCHAR as unit, streetname, 
	zip, INITCAP(postalcity) AS city, b.name,
	bldg_type, ROUND(height_est * .3048,1) AS height, no_addr, b.geom 
FROM bothell_addr a, bothell_bldg b
WHERE b.gid=bldg_id AND no_addr = 1 and dup is true
UNION
SELECT 0::integer as aid,b.gid as bid,NULL AS addr_num, NULL AS unit, ''::VARCHAR(80) AS streetname,
	''::VARCHAR(5) AS zip, ''::VARCHAR(50) AS city, b.name,
	bldg_type, ROUND(height_est * .3048,1) as height, no_addr, b.geom
FROM bothell_addr a, bothell_bldg b
WHERE ST_CONTAINS(b.geom, a.geom) AND no_addr > 1 
UNION
SELECT 0::integer as aid,gid as bid, NULL AS addr_num, NULL AS unit, ''::VARCHAR(80) AS streetname,
	''::VARCHAR(5) AS zip, ''::VARCHAR(50) AS city, name,
	bldg_type, ROUND(height_est * .3048,1 ) as height, no_addr, geom
FROM bothell_bldg WHERE no_addr IS NULL);

ALTER TABLE bothell_ba
	OWNER TO clifford;
