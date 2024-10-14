# Let's create a temporary container called "builder" to create production code
FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# It will build the deployment files in /app/build
RUN npm run build

FROM nginx
# Here we are going to copy the result from the previous step into the
# directory that nginx is expecting to find the html code.
COPY --from=builder /app/build /usr/share/nginx/html
# We don't need to start the nginx ourselves, because this image already does it for us
