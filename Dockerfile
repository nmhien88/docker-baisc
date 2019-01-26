FROM centos:7
MAINTAINER nmhien889@gmail.com
RUN yum clean all
RUN sudo yum -y update
RUN sudo yum -y install httpd

WORKDIR /myenv
COPY run.sh /myenv
RUN chmod a+x /myenv/*

ENTRYPOINT [ "/myenv/run.sh" ]

EXPOSE 80