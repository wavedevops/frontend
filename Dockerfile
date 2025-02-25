#FROM nginx
#
## Remove default content
#RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/*
#
## Copy configuration file
#COPY expense.conf /etc/nginx/conf.d/expense.conf
#
## Copy static files
#COPY static/ /usr/share/nginx/html/static/
#
## Copy other necessary files
#COPY asset-manifest.json index.html robots.txt /usr/share/nginx/html/
#
## Start Nginx in the foreground
#ENTRYPOINT ["nginx", "-g", "daemon off;"]
#
#


#FROM        dokken/centos-8
#RUN         dnf install nginx unzip -y
#RUN         dnf install unzip -y
#RUN         rm -rf /usr/share/nginx/html/*
#RUN         curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip
#RUN         cd /usr/share/nginx/html ; unzip /tmp/frontend.zip
#ADD         expense.conf /etc/nginx/default.d/expense.conf
#ENTRYPOINT  ["nginx", "-g", "daemon off;"]
#EXPOSE      80
#


FROM        dokken/centos-8
RUN         dnf install nginx  -y
RUN         rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/*
COPY        expense.conf /etc/nginx/conf.d/expense.conf
COPY        static/ /usr/share/nginx/html/static/
COPY        asset-manifest.json index.html robots.txt /usr/share/nginx/html/
ENTRYPOINT  ["nginx", "-g", "daemon off;"]
EXPOSE      80

