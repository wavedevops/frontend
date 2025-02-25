FROM almalinux:8


# Install Nginx
RUN dnf install -y nginx && \
    rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/* && \
    mkdir -p /usr/share/nginx/html/static && \
    dnf clean all

# Copy configuration and static files
COPY expense.conf /etc/nginx/conf.d/expense.conf
COPY static/ /usr/share/nginx/html/static/
COPY asset-manifest.json index.html robots.txt /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
