#FROM dokken/centos-8
#
## Install Nginx
#RUN dnf install -y nginx && dnf clean all
#
## Remove default HTML content
#RUN rm -rf /usr/share/nginx/html/*
#
## Copy static files to Nginx web directory
#ADD static/ asset-manifest.json index.html robots.txt /usr/share/nginx/html/
#
#ADD expense.conf /etc/nginx/default.d/expense.conf
#
## Expose port 80
#EXPOSE 80
#
## Start Nginx
#CMD ["nginx", "-g", "daemon off;"]

FROM dokken/centos-8

# Install Nginx
RUN dnf install -y nginx && dnf clean all

# Remove default HTML content
RUN rm -rf /usr/share/nginx/html/*

# Copy static files to Nginx web directory
COPY static/ asset-manifest.json index.html robots.txt /usr/share/nginx/html/

# Copy Nginx configuration file
COPY expense.conf /etc/nginx/default.d/expense.conf

# Set correct permissions
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Use ENTRYPOINT to run Nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
