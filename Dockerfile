FROM centos/s2i-base-centos7

EXPOSE 8080

ENV SPRING_BOOT_KONG_VERSION=1.0.0 \
    MAVEN_VERSION=3.5.0 \
    JAVA_HOME=/usr/lib/jvm/java \
    M2_HOME=/usr/local/maven
ENV PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH 

ARG APACHE_MIRROR=http://mirror.stjschools.org/public/apache
ARG MAVEN_NAME=apache-maven-${MAVEN_VERSION}

LABEL io.k8s.description="Platform for building Spring Boot microservices exposed by Kong API Gateway" \
     io.k8s.display-name="Spring Boot Kong" \
     io.openshift.expose-services="8080:http" \
     io.openshift.tags="builder,spring-boot,kong"

RUN yum install -y java-1.8.0-openjdk-devel && \
    mkdir -p $M2_HOME && \
    (curl $APACHE_MIRROR/maven/maven-3/$MAVEN_VERSION/binaries/$MAVEN_NAME-bin.tar.gz | \
        tar -xz -C $M2_HOME --strip-components 1) && \
    mkdir -p /spring-boot/config && \
    mkdir -p $HOME/.m2 && \
    yum clean all -y

COPY ./contrib/settings.xml $HOME/.m2/
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

RUN chown -R 1001:0 /spring-boot && \
    chmod -R ug+rw /spring-boot && \
    chown -R 1001:0 $HOME && \
    chmod -R ug+rw $HOME

# This default user is created in the openshift/base-centos7 image
USER 1001

CMD $STI_SCRIPTS_PATH/usage
