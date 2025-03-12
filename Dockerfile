# Use AlmaLinux 8 (CentOS replacement with ARM64 support)
FROM almalinux:8

# Install Nginx and clean up cache
RUN dnf install -y nginx && dnf clean all && rm -rf /var/cache/dnf

# Remove default HTML content
RUN rm -rf /usr/share/nginx/html/*

# Copy static website files
COPY static/ /usr/share/nginx/html/
COPY asset-manifest.json index.html robots.txt /usr/share/nginx/html/

# Copy custom Nginx configuration
COPY expense.conf /etc/nginx/default.d/expense.conf

# Set correct permissions
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx using ENTRYPOINT
ENTRYPOINT ["nginx", "-g", "daemon off;"]
