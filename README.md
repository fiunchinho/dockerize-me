# Dockerize Me
[![MicroBadger](https://images.microbadger.com/badges/image/fiunchinho/dockerize-me.svg)](https://microbadger.com/images/fiunchinho/dockerize-me "Get your own image badge on microbadger.com")
[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/r/fiunchinho/dockerize-me/)
[![Docker Pulls](https://img.shields.io/docker/pulls/fiunchinho/dockerize-me.svg?maxAge=2592000)]()
[![Docker Stars](https://img.shields.io/docker/stars/fiunchinho/dockerize-me.svg?maxAge=2592000)]()

Tired of copy/pasting Dockerfiles around? Not sure about best practices for Dockerfiles or Docker entry points?
This tool lets you Dockerize your applications using [best practices](https://github.com/docker-library/official-images#review-guidelines) to define your Dockerfile and Docker entry point files.

You just need to mount your app into the `/app` folder and follow the instructions.
It'll generate a valid `Dockerfile`, and, if needed, a valid `docker-entrypoint.sh` file to be used as entry point.

## Example
You can run this utility with Docker

```bash
$ docker run -it --rm -v $PWD:/app fiunchinho/dockerize-me

Your email: alice@wonderland.com
Your full name: Alice Wonderland
Does the container run Java? [False] 
Which file/folder needs to be copied to the container? It'll be copied into '/app' [.] 
Which port do you want to expose? [No ports exposed] 
Do you need an entrypoint to do stuff before running the app? [False] 
Which command needs to be executed to start your application? Your app lives in '/app' python /app/dockerize-me/dockerize.py
System dependencies (f.e python=2.7.11-r3 py-pip=7.1.2-r0): python=2.7.11-r3 py-pip=7.1.2-r0
App dependencies command (f.e pip install -r requirements.txt): [False] pip install -r requirements.txt

You can build your container running the following command: 
docker build \ 
    --build-arg vcs_type=git \ 
    --build-arg vcs_url=`git config --get remote.origin.url` \ 
    --build-arg vcs_branch=`git rev-parse --abbrev-ref HEAD` \ 
    --build-arg vcs_ref=`git rev-parse HEAD` \ 
    --build-arg build_date=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    -t your_image .
```

This has generated a Dockerfile.
If you have selected to use a docker entrypoint, a file called `docker-entrypoint.sh` will be generated. Before building your image, give execution permissions to this file.

## Motivation
This project allow people to easily create nice Dockerfiles to dockerize their applications. Besides, it's a way to document how to craft good Docker images.

## Images
This tool uses the following images to keep your Docker images as tiny as possible
- [anapsix/alpine-java](https://hub.docker.com/r/anapsix/alpine-java/) When selecting a Java project
- [alpine](https://hub.docker.com/_/alpine/) For the rest

## Init system
We use [tini](https://github.com/krallin/tini) as init system, so you don't have problems [with signals or zombie processes](https://github.com/docker-library/official-images#init).

## Metadata
All our images have special labels that help us determine which is inside the image. This tool also copies the Dockerfile used to build the image inside the container.
The labels added to the images are
- `org.label-schema.vcs-type` type of vcs like Git or Subversion
- `org.label-schema.vcs-url` url of the git repository
- `org.label-schema.vcs-ref` sha1 hash of the commit when the image was built
- `org.label-schema.vcs-branch` git branch when the image was built
- `org.label-schema.docker.dockerfile` path to the Dockerfile inside the container. Normally `/Dockerfile`
- `org.label-schema.build-date` date and time when the image was built

Once you've generated the `Dockerfile`, you can build your image with

```bash
docker build \ 
    --build-arg vcs_type=git \ 
    --build-arg vcs_url=`git config --get remote.origin.url` \ 
    --build-arg vcs_branch=`git rev-parse --abbrev-ref HEAD` \ 
    --build-arg vcs_ref=`git rev-parse HEAD` \ 
    --build-arg build_date=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \ 
    -t your_image_name .
```

## Developer Experience
[Trying to make life easier for developers](https://github.com/docker-library/official-images#consistency), images that need a docker entry point and images that don't, they both accept commands the same way. Images created with this tool let you
- Run the default command `docker run -it --rm -v $PWD:/app fiunchinho/dockerize-me`
- Get an shell `docker run -it --rm -v $PWD:/app fiunchinho/dockerize-me sh`
- Use a different command `docker run -it --rm -v $PWD:/app fiunchinho/dockerize-me python --version`

## Credits
I learn many of these concepts thanks to [garethr](https://twitter.com/garethr), [jpetazzo](https://twitter.com/jpetazzo) or [jbaruch](https://twitter.com/jbaruch). You should definitely listen to them.
