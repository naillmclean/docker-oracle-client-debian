# Image with Linux Oracle instant client for debian. 

FROM buildpack-deps:jessie
MAINTAINER Naill Mclean <naill_mclean@hotmail.com>

ADD . /tmp/
RUN if [ -f /tmp/oracle*basic*.rpm ] ; then echo "Oracle rpm files found, now installing..." ; else echo "No Oracle rpm files, exiting" ; fi
COPY ./oracle* /tmp/
RUN apt-get update
RUN apt-get -y install libaio1
RUN apt-get -y install alien
RUN alien -k -d -i /tmp/*.rpm 
RUN mkdir /usr/lib/oracle/12.1/client64/network/admin -p
COPY ./tnsnames.ora /usr/lib/oracle/12.1/client64/network/admin/tnsnames.ora

ENV ORACLE_HOME=/usr/lib/oracle/12.1/client64
ENV PATH=$PATH:$ORACLE_HOME/bin
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib
ENV TNS_ADMIN=$ORACLE_HOME/network/admin

ENTRYPOINT /bin/bash