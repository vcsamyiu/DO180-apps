FROM ubi7/ubi:7.7
MAINTAINER sam sam@ibm.com
ENV NEXUS_VERSION=2.14.3-02
ENV NEXUS_HOME=/opt/nexus

RUN yum install -y --setopt=tsflags=nodocs java-1.8.0-openjdk-devel && yum clean all -y

COPY ./training.repo /etc/yum.repos.d/
RUN groupadd -r nexus -f -g 1001 && useradd -u 1001 -r -g nexus -m -d ${NEXUS_HOME} \
        -s /sbin/nologin \
        -c "Nexus User" nexus
ADD nexus-2.14.3-02-bundle.tar.gz ${NEXUS_HOME}/
ADD ./nexus-start.sh ${NEXUS_HOME}/

RUN ls -laF ${NEXUS_HOME} && sleep 5

RUN ln -s ${NEXUS_HOME}/nexus-${NEXUS_VERSION} ${NEXUS_HOME}/nexus2
RUN chown -R nexus:nexus ${NEXUS_HOME}/
RUN chmod -R 755 ${NEXUS_HOME}/
USER nexus
WORKDIR /opt/nexus
VOLUME ["/opt/nexus/sonatype-work"]

CMD ["/opt/nexus/nexus-start.sh"]
