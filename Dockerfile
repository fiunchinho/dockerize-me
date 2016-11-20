FROM alpine:3.4

MAINTAINER Jose Armesto <jose@armesto.net>

ARG vcs_type="git"
ARG vcs_url="https://github.com/fiunchinho/dockerize-me"
ARG vcs_ref="Unknown"
ARG vcs_branch="Unknown"
ARG build_date="Unknown"

VOLUME ["/app"]

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["python", "/app/dockerize-me/dockerize.py"]

COPY ./Dockerfile /Dockerfile

RUN apk add --update --repository https://dl-cdn.alpinelinux.org/alpine/edge/community/ tini=0.9.0-r1 py-pip=8.1.2-r0 && \
    adduser -u 10001 -D -h /app app

WORKDIR /app

LABEL org.label-schema.vcs-type=git \
      org.label-schema.vcs-url=$vcs_url \
      org.label-schema.vcs-ref=$vcs_ref \
      org.label-schema.vcs-branch=$vcs_branch \
      org.label-schema.docker.dockerfile=/Dockerfile \
      org.label-schema.build-date=$build_date

COPY . /app

RUN pip install -r requirements.txt
USER app