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

# Use CentOS Stream 8 (ARM64 supported)
FROM quay.io/centos/centos:stream8

# Install Nginx and clean up cache
RUN dnf install -y nginx

# Remove default HTML content
RUN rm -rf /usr/share/nginx/html/*

# Copy static website files
COPY static/ /usr/share/nginx/html/
COPY asset-manifest.json index.html robots.txt /usr/share/nginx/html/

# Copy custom Nginx configuration
COPY expense.conf /etc/nginx/default.d/expense.conf

# Set correct permissions
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Use ENTRYPOINT instead of CMD
ENTRYPOINT ["nginx", "-g", "daemon off;"]
