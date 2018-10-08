DROP VIEW bothell_ba;
CREATE OR REPLACE VIEW bothell_ba AS(
SELECT distinct b.gid AS bid, a.gid AS aid, addr_num, unit, streetname, 
	zip, INITCAP(postalcity) AS city, b.name,
	bldg_type, ROUND(height_est * .3048,1) AS height, no_addr, 
	a.unit_bldg, b.geom 
FROM bothell_addr a, bothell_bldg b
WHERE b.gid=bldg_id AND no_addr = 1
UNION
SELECT DISTINCT ON (b.gid) b.gid AS bid, 0::integer AS aid, NULL AS addr_num, NULL AS unit, ''::VARCHAR(80) AS streetname,
        ''::VARCHAR(5) AS zip, ''::VARCHAR(50) AS city, b.name,
        bldg_type, ROUND(height_est * .3048,1) AS height, no_addr,
        a.unit_bldg, b.geom
FROM bothell_bldg b, bothell_addr a
WHERE b.gid=bldg_id AND no_addr > 1 AND bldg_type = 'Multi Family'
UNION
SELECT DISTINCT ON (b.gid) b.gid AS bid, 0::integer AS aid, NULL AS addr_num, NULL AS unit, ''::VARCHAR(80) AS streetname,
        ''::VARCHAR(5) AS zip, ''::VARCHAR(50) AS city, b.name,
        bldg_type, ROUND(height_est * .3048,1) AS height, no_addr,
        a.unit_bldg, b.geom
FROM bothell_bldg b, bothell_addr a
WHERE b.gid=bldg_id AND no_addr > 1 AND bldg_type = 'Commercial'
UNION
SELECT DISTINCT ON (b.gid) b.gid AS bid, 0::integer AS aid, NULL AS addr_num, NULL AS unit, ''::VARCHAR(80) AS streetname,
	''::VARCHAR(5) AS zip, ''::VARCHAR(50) AS city, b.name,
	bldg_type, ROUND(height_est * .3048,1) AS height, no_addr, 
	a.unit_bldg, b.geom
FROM bothell_bldg b, bothell_addr a
WHERE ST_CONTAINS(b.geom, a.geom) AND no_addr > 1 AND bldg_type NOT IN ('Multi Family','Commercial')
UNION
SELECT gid AS bid, 0::integer AS aid, NULL AS addr_num, NULL AS unit, ''::VARCHAR(80) AS streetname,
	''::VARCHAR(5) AS zip, ''::VARCHAR(50) AS city, name,
	bldg_type, ROUND(height_est * .3048,1 ) AS height, no_addr, 
	''::VARCHAR(4) AS unit_bldg, geom
FROM bothell_bldg WHERE no_addr IS NULL);

ALTER TABLE bothell_ba
	OWNER TO clifford;
