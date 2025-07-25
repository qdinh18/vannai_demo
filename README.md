# Real Estate Data Analysis with Vanna.ai

This project demonstrates how to set up a PostgreSQL database with real estate data and use the Vanna.ai library to generate SQL queries from natural language questions.

## Project Structure

```
.
├── data/                     # Contains the CSV data files
│   ├── dim_broker.csv
│   ├── dim_post.csv
│   ├── dim_project.csv
│   └── fact_all_apartment.csv
├── postgres/                 # PostgreSQL container configuration
│   ├── Dockerfile
│   └── init.sql              # Database initialization script
├── docker-compose.yaml       # Docker Compose configuration
├── vannai.ipynb              # Jupyter notebook for data analysis with Vanna
└── README.md                 # This file
```


## Setup

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <repository-name>
    ```

2.  **Build and start the PostgreSQL container:**
    This command will build the Docker image for PostgreSQL, create a container, and load the data from the `data/` directory into the database.

    ```bash
    docker-compose up --build -d
    ```

3.  **Verify the container is running:**
    ```bash
    docker ps
    ```
    You should see a container named `postgresql` in the output.
    
4.  **Verify data has been loaded:**
    Run the following command to count the rows in the `fact_all_apartment` table. You should see a count greater than zero.
    ```bash
    docker exec postgresql psql -U admin -d mydb -c "SELECT COUNT(*) FROM fact_all_apartment;"
    ```

## Database

The `docker-compose.yaml` file sets up a PostgreSQL database with the following credentials:
-   **Host**: `localhost`
-   **Port**: `5432`
-   **Username**: `admin`
-   **Password**: `admin`
-   **Database**: `mydb`

The database is initialized with the tables defined in `postgres/init.sql` and populated with data from the CSV files in the `data/` directory.

You can connect to the database using any SQL client or by running the following command to get a `psql` shell:
```bash
docker exec -it postgresql psql -U admin -d mydb
```

## Usage with Vanna.ai

The `vannai.ipynb` notebook provides an interactive environment to analyze the real estate data using Vanna.ai.

### Running the Notebook

1.  **Register for a Vanna.ai API Key:**
    Before using the notebook, you need to get a free API key from Vanna.ai.
    - Go to [https://app.vanna.ai/register](https://app.vanna.ai/register) to sign up.
    - You will need this for the Jupyter notebook.


2.  **Open `vannai.ipynb`** in your browser.

3.  **Follow the steps in the notebook:** The notebook will guide you through:



---
Enjoy exploring your data with Vanna.ai! 