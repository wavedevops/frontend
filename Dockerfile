FROM arm64v8/nginx:stable-alpine-otel


# Install Nginx
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/* && \
    mkdir -p /usr/share/nginx/html/static

# Copy configuration and static files
COPY expense.conf /etc/nginx/conf.d/expense.conf
COPY static/ /usr/share/nginx/html/static/
COPY asset-manifest.json index.html robots.txt /usr/share/nginx/html/

# Expose port 80
EXPOSE 81

# Start Nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
