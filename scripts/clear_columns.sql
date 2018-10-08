UPDATE bothell_parcel SET no_bldgs = NULL;
UPDATE bothell_parcel SET no_addr = NULL;
UPDATE bothell_addr SET bldg_id = NULL;
UPDATE bothell_addr SET parcel_gid = NULL;
UPDATE bothell_bldg SET parcel_gid = NULL;
UPDATE bothell_bldg SET no_addr = NULL;

