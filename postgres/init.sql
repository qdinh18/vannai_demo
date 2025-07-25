
CREATE TABLE IF NOT EXISTS dim_broker (
    broker_id      SERIAL PRIMARY KEY,
    update_date    DATE NOT NULL,
    broker_name    TEXT,
    broker_rank    TEXT
);

CREATE TABLE IF NOT EXISTS dim_post (
    post_id        SERIAL PRIMARY KEY,
    update_date    DATE NOT NULL,
    title          TEXT,
    url            TEXT,
    posted_date    DATE,
    expired_date   DATE
);

CREATE TABLE IF NOT EXISTS dim_project (
    project_id             SERIAL PRIMARY KEY,
    update_date            DATE NOT NULL,
    project_name           TEXT,
    investor               TEXT,
    project_area_range     TEXT,
    project_status         TEXT,
    address                TEXT,
    number_of_apartments   REAL,
    number_of_buildings    REAL
);

CREATE TABLE IF NOT EXISTS fact_all_apartment (
    post_id               INT,
    update_date           DATE NOT NULL,
    broker_id             INT,
    project_id            INT,
    price                 FLOAT,
    price_unit            TEXT,
    price_per_m2          FLOAT,
    price_per_m2_unit     TEXT,
    area                  FLOAT,
    area_unit             TEXT,
    bedroom               REAL,
    bathroom              REAL
);

CREATE TEMP TABLE tmp_broker (
    broker_id      INT,
    update_date    DATE NOT NULL,
    broker_name    TEXT,
    broker_rank    TEXT
);

CREATE TEMP TABLE tmp_post (
    post_id        INT,
    update_date    DATE NOT NULL,
    title          TEXT,
    url            TEXT,
    posted_date    DATE,
    expired_date   DATE
);

CREATE TEMP TABLE tmp_project (
    project_id             INT,
    update_date            DATE NOT NULL,
    project_name           TEXT,
    investor               TEXT,
    project_area_range     TEXT,
    project_status         TEXT,
    address                TEXT,
    number_of_apartments   TEXT,
    number_of_buildings    TEXT
);

CREATE TEMP TABLE tmp_fact_all_apartment (
    post_id               INT,
    update_date           DATE NOT NULL,
    broker_id             INT,
    project_id            INT,
    price                 TEXT,
    price_unit            TEXT,
    price_per_m2          TEXT,
    price_per_m2_unit     TEXT,
    area                  TEXT,
    area_unit             TEXT,
    bedroom               TEXT,
    bathroom              TEXT
);

COPY tmp_broker FROM '/docker-entrypoint-initdb.d/dim_broker.csv' DELIMITER ',' CSV HEADER;
INSERT INTO dim_broker (update_date, broker_name, broker_rank)
SELECT update_date, broker_name, broker_rank FROM tmp_broker;

COPY tmp_post FROM '/docker-entrypoint-initdb.d/dim_post.csv' DELIMITER ',' CSV HEADER;
INSERT INTO dim_post (update_date, title, url, posted_date, expired_date)
SELECT update_date, title, url, posted_date, expired_date FROM tmp_post;

COPY tmp_project FROM '/docker-entrypoint-initdb.d/dim_project.csv' DELIMITER ',' CSV HEADER;
INSERT INTO dim_project (update_date, project_name, investor, project_area_range, project_status, address, number_of_apartments, number_of_buildings)
SELECT update_date, project_name, investor, project_area_range, project_status, address, NULLIF(number_of_apartments, 'NULL')::REAL, NULLIF(number_of_buildings, 'NULL')::REAL FROM tmp_project;

COPY tmp_fact_all_apartment FROM '/docker-entrypoint-initdb.d/fact_all_apartment.csv' DELIMITER ',' CSV HEADER;
INSERT INTO fact_all_apartment (post_id, update_date, broker_id, project_id, price, price_unit, price_per_m2, price_per_m2_unit, area, area_unit, bedroom, bathroom)
SELECT post_id, update_date, broker_id, project_id, NULLIF(price, 'NULL')::FLOAT, price_unit, NULLIF(price_per_m2, 'NULL')::FLOAT, price_per_m2_unit, NULLIF(area, 'NULL')::FLOAT, area_unit, NULLIF(bedroom, 'NULL')::REAL, NULLIF(bathroom, 'NULL')::REAL FROM tmp_fact_all_apartment; 