FROM postgres:13

COPY ./data/dim_broker.csv /docker-entrypoint-initdb.d/dim_broker.csv
COPY ./data/dim_post.csv /docker-entrypoint-initdb.d/dim_post.csv
COPY ./data/dim_project.csv /docker-entrypoint-initdb.d/dim_project.csv
COPY ./data/fact_all_apartment.csv /docker-entrypoint-initdb.d/fact_all_apartment.csv
COPY ./postgres/init.sql /docker-entrypoint-initdb.d/init.sql 