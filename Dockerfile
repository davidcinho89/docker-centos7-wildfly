FROM centos:7
RUN yum install -y java-1.8.0-openjdk-devel
RUN yum install -y git

#RUN useradd fuse

RUN mkdir -p /usr/local/src/apache-maven
#RUN mkdir -p ${user.home}/.m2/repository
RUN mkdir -p /opt/wildfly

COPY ./maven/ /usr/local/src/apache-maven/

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
ENV PATH=${JAVA_HOME}/bin:${PATH}

ENV M2_HOME=/usr/local/src/apache-maven
ENV PATH=${M2_HOME}/bin:${PATH}

COPY ./wildfly/ /opt/wildfly/

ENV JBOSS_HOME=/opt/wildfly
ENV PATH=${JBOSS_HOME}/bin:${PATH}
#RUN chown -R fuse:fuse /opt/rh/fuse

#VOLUME /opt/rh/fuse/data
#VOLUME /opt/rh/fuse/deploy

WORKDIR /opt/wildfly/

EXPOSE 8080 9990
ENTRYPOINT ["/opt/wildfly/bin/standalone.sh"]

