FROM node:18.17.1 as build
WORKDIR /app
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
COPY . /app
RUN npm install
RUN npm run build

FROM nginx:1.25.2
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]