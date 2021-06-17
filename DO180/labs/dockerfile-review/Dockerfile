FROM ubi7/ubi:7.7

MAINTAINER username <username@example.com>

ENV PORT 8080

RUN yum install httpd -y && yum install unzip -y && yum clean all 

RUN sed -ri -e "/^Listen 80/c\Listen ${PORT}" /etc/httpd/conf/httpd.conf && \
    chown -R apache:apache /etc/httpd/logs/ && \
    chown -R apache:apache /run/httpd/ && echo ${PORT}
RUN mkdir -v /sam && mkdir -v /samg && mkdir -v /samzip
ADD sam.tar /sam
RUN ls -laF /sam && sleep 5
ADD sam.tar.tgz /samg
ADD sam.zip /samzip
RUN unzip /samzip/sam.zip -d /samzip
RUN echo 

RUN ls -laF /samg && sleep 5
RUN ls -laF /samzip && sleep 5

# RUN echo "ls -laF >/sam/samlist.txt;exec tail -f /dev/null" > /sam/list.sh
# RUN touch /sam/samlist.txt
RUN echo "tail -f /dev/null" > /sam/list.sh

RUN chown -R nobody:nobody /sam
RUN chmod -R 777 /sam


USER apache

# Expose the custom port that you provided in the ENV var
EXPOSE 8080

# Copy all files under src/ folder to Apache DocumentRoot (/var/www/html) 

WORKDIR /sam
ADD ./src /var/www/html
RUN ls -laF /var/www/html && sleep 5

# Start Apache in the foreground

# CMD ["tail", "-f","/dev/null"]

# CMD ["httpd","-D","FOREGROUND"]

ENTRYPOINT ["tail"]
#CMD ["/sam/list.sh"]
CMD ["-f","/dev/null"]
