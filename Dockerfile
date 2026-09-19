FROM nginx
EXPOSE 80
MAINTAINER satish
LABEL This is for the task
COPY index.html /usr/share/nginx/html
