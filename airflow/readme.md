# Airflow deployment

Easy to use script to run airflow with basic dags

## Requirements
- python3
- docker
- docker-compose

## Usage
- Install requirements
  ```bash
  pip install pip install -r requirements.txt  
  ```
- Run
  ```bash
  docker-compose -f docker-airflow/docker-compose-CeleryExecutor.yml up --build
  ```
- Wait until service becomes healthy(dashboard available on http://localhost:8080/)
- On dashboard in admin/connections add new connection with name **database_PG** and with data from docker-compose-CeleryExecutor.yml postgres service description, ip address get with command
  ```bash
  docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' id_of_postrgres_container
  ```
- Create new token on *worldweatheronline* and add it in admin/value by name **KEY_API_WWO**  
- ✨Magic ✨
 