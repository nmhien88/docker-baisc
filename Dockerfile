FROM centos:7.0.1406
MAINTAINER nmhien889@gmail.com
RUN yum clean all
RUN yum -y update
RUN yum -y install httpd
 
RUN yum swap -y fakesystemd systemd && \
    yum install -y systemd-devel

RUN yum -y install epel-release
RUN yum -y install php56w-fpm php56w-opcache php56w-common

WORKDIR /myenv
COPY run.sh /myenv
RUN chmod a+x /myenv/*

ENTRYPOINT [ "/myenv/run.sh" ]

EXPOSE 80