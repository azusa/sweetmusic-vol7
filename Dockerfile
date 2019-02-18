FROM fieldnotesjp.azurecr.io/pandoc-viola-savepdf-ja:2.6.1
MAINTAINER Hiroyuki Onaka


RUN mkdir -p /tmp/code
ADD . /tmp/code/
RUN rm -rf /tmp/code/target
RUN mkdir -p /tmp/code/target


WORKDIR /tmp/code

CMD bash /tmp/code/build.sh
