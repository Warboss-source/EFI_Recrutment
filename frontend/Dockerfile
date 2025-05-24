FROM node:16-alpine
WORKDIR /app/frontend

COPY src/ /app/frontend/src/
COPY *.json /app/frontend/
COPY .eslintrc /app/frontend/
COPY *.js /app/frontend/

RUN cd /app/frontend
RUN npm i 

EXPOSE 8000

CMD [ "npm", "start" ]
