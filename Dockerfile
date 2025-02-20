FROM        nginx
RUN         rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/*
ADD         expense.conf /etc/nginx/conf.d/expense.conf
ADD         static/ /usr/share/nginx/html/static/
ADD         asset-manifest.json index.html robots.txt /usr/share/nginx/html/
USER nginx
CMD ["nginx", "-g", "daemon off;"]
