# Define the basic image
FROM debian:buster 

# RUN: execute a command in a container
# Update the server OS and install nginx
RUN apt-get update && \
    apt-get -y install nginx openssl

# Create a self-signed key and certificate pair
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/jnougaro.42.fr.key \
    -out /etc/ssl/certs/jnougaro.42.fr.crt \
    -subj "/C=FR/ST=Paris/O=42 School/OU=jnougaro/CN=jnougaro@student.42.fr"
    
# To copy nginx.conf in the container
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Port the application listens to
EXPOSE 443

# Always defined and by convention is placed at the end
# All the commands before are used to define/construct the container
# Define which command will be executed first when launching the container
# Tell Nginx to stay in the foreground / One server (container) has only one service
CMD ["nginx", "-g", "daemon off;"]