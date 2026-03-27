#stage 1: Build the React_Application:


FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install --force

COPY . .

RUN npm run build

#stage2 = Serve the App with nginx:


FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

#copy your nginx custom conf:

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
