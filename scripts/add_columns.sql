-- add new columns into bothell addr, bldg and parcel tables

ALTER TABLE bothell_addr 
	ADD COLUMN bldg_id INTEGER,
	ADD COLUMN parcel_gid INTEGER,
	ADD COLUMN streetname VARCHAR(80),
	ADD COLUMN predir VARCHAR(80),
	ADD COLUMN street VARCHAR(80),
	ADD COLUMN street_typ VARCHAR(80),
	ADD COLUMN postdir VARCHAR(80);

ALTER TABLE bothell_bldg
	ADD COLUMN parcel_gid INTEGER,
	ADD COLUMN no_addr INTEGER;

ALTER TABLE bothell_parcel 
	ADD COLUMN no_bldgs INTEGER,
	ADD COLUMN no_addr INTEGER;
