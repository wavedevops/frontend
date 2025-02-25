FROM nginx

# Remove default content
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/*

# Copy configuration file
COPY expense.conf /etc/nginx/conf.d/expense.conf

# Copy static files
COPY static/ /usr/share/nginx/html/static/

# Copy other necessary files
COPY asset-manifest.json index.html robots.txt /usr/share/nginx/html/

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]






