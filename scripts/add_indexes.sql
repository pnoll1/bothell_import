-- add new columns into bothell addr, bldg and parcel tables

CREATE INDEX IF NOT EXISTS bothell_addr_gist ON bothell_addr USING GIST(geom);

CREATE INDEX IF NOT EXISTS bothell_bldg_gist ON bothell_bldg USING GIST(geom);

CREATE INDEX IF NOT EXISTS bothell_parcel_gist ON bothell_parcel USING GIST(geom);

CREATE INDEX IF NOT EXISTS bothell_votdst_gist ON bothell_votdst USING GIST(geom);
