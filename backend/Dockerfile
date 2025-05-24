FROM node:16-alpine
WORKDIR /app/backend

COPY src/* /app/backend/src/
COPY *.json /app/backend/
COPY .eslintrc /app/backend/

RUN cd /app/backend
RUN npm i

EXPOSE 9000

CMD [ "npm", "start" ]