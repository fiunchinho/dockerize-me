FROM alpine:3.3

MAINTAINER Jose Armesto <jose@armesto.net>

ARG vcs_type="git"
ARG vcs_url="Unknown"
ARG vcs_ref="Unknown"
ARG vcs_branch="Unknown"
ARG build_date="Unknown"

VOLUME ["/code"]

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["python", "/opt/dockerize-me/dockerize.py"]

COPY ./Dockerfile /Dockerfile


RUN apk add --update --repository https://dl-cdn.alpinelinux.org/alpine/edge/community/ tini=0.9.0-r1 python=2.7.11-r3 py-pip=7.1.2-r0

LABEL org.label-schema.vcs-type=git \
      org.label-schema.vcs-url=$vcs_url \
      org.label-schema.vcs-ref=$vcs_ref \
      org.label-schema.vcs-branch=$vcs_branch \
      org.label-schema.docker.dockerfile=/Dockerfile \
      org.label-schema.build-date=$build_date

WORKDIR /opt

COPY . /opt/

RUN pip install -r requirements.txt
