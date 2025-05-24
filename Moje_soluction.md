# Recruitment tasks overview

Case: setup working weather app with frontend and backend on AWS. Use terraform for IaC to automate setting up environment and ansible for deploying application to both front and back. Testing in docker


## Docker app start

1. Add your API KEY to weatherapp into .env file in following format:
```
export APPID='keykeykeykey'
```

2. Run backend container
```
source .env
docker build backend/. -t weatherapp_backend
docker run -d --rm -p 9000:9000 -e APPID=$APPID --name weatherapp_backend -t weatherapp_backend
```

3. Run frontend container
```
docker build frontend/. -t weatherapp_frontend
docker run -d --rm -p 8000:8000 --name weatherapp_frontend -t weatherapp_frontend
```

4. Optional: change location weather
To do so you need to change backend default env parameter
```
docker run -d --rm -p 9000:9000 -e APPID=$APPID -e TARGET_CITY="Helsinki,fi" --name weatherapp_backend -t weatherapp_backend
```