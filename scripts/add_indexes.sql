-- add new columns into bothell addr, bldg and parcel tables

CREATE INDEX bothell_addr_gist ON bothell_addr USING GIST(geom);

CREATE INDEX bothell_bldg_gist ON bothell_bldg USING GIST(geom);

CREATE INDEX bothell_parcel_gist ON bothell_parcel USING GIST(geom);

CREATE INDEX bothell_votdst_gist ON bothell_votdst USING GIST(geom);
