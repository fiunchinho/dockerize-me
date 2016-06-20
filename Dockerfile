FROM alpine:3.3

MAINTAINER Jose Armesto <jose@armesto.net>

ARG git_repository="Unknown"
ARG git_commit="Unknown"
ARG git_branch="Unknown"
ARG built_on="Unknown"

VOLUME ["/code"]

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["python", "/opt/dockerize-me/dockerize.py"]

COPY ./Dockerfile /Dockerfile


RUN apk add --update --repository https://dl-cdn.alpinelinux.org/alpine/edge/community/ tini=0.9.0-r1 python=2.7.11-r3 py-pip=7.1.2-r0

LABEL git.repository=$git_repository \
      git.commit=$git_commit \
      git.branch=$git_branch \
      build.dockerfile=/Dockerfile \
      build.on=$built_on

WORKDIR /opt

COPY . /opt/

RUN pip install -r requirements.txt
