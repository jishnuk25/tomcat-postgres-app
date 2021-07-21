FROM tomcat

ADD target/*.war /usr/share/tomcat/webapps/

EXPOSE 8080