# Recruitment tasks overview

Case: setup working weather app with frontend and backend on AWS. Use terraform for IaC to automate setting up environment and ansible for deploying application to both front and back. Testing in docker


## Docker app start separately every container

1. Add your API KEY to weatherapp into .env file in following format:
```bash
APPID='keykeykeykey'
```

2. Run backend container
```bash
source .env
docker build backend/. -t weatherapp_backend:1.1
docker run -d --rm -p 9000:9000 -e APPID=$APPID --name weatherapp_backend -t weatherapp_backend
```

3. Run frontend container
```bash
docker build frontend/. -t weatherapp_frontend:1.1
docker run -d --rm -p 8000:8000 --name weatherapp_frontend -t weatherapp_frontend
```

4. Optional: change location weather
To do so you need to change backend default env parameter
```bash
docker run -d --rm -p 9000:9000 -e APPID=$APPID -e TARGET_CITY="Helsinki,fi" --name weatherapp_backend -t weatherapp_backend
```

## Docker compose example

1. 1. Add your API KEY to weatherapp into .env file in following format:
```bash
APPID='keykeykeykey'
```

2. Build backend image
```bash
docker build backend/. -t weatherapp_backend:1.1
```

3. Build frontend image
```bash
docker build frontend/. -t weatherapp_frontend:1.1
```

4. Start containers with compose
```bash
docker-compose up
```

5. Optional: change location weather
To do so you need to change backend default env parameter: edit .env file and change tag of city in TARGET_CITY variable
