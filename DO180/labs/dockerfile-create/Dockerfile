FROM ubi7/ubi:7.7
MAINTAINER Your Name <youremail>
LABEL description="A custom Apache container based on UBI 7"
RUN yum install -y httpd && yum clean all
RUN echo "Hello from Dockerfile" > /var/www/html/index.html
EXPOSE 81 82 83 443
# tech 1 ENTRYPOINT ["httpd"]
# tech 1 CMD ["-D","FOREGROUND"]

# tech 2 CMD ["httpd","-D","FOREGROUND]

CMD httpd -D FOREGROUND
