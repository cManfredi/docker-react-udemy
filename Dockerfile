# Build phase - 'as' tags the phase
FROM node:alpine as builder
WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .
RUN npm run build

# Run phase
FROM nginx
#AWS uses this line to know what port to expose on the server
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# default CMD starts nginx