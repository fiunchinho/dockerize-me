# Docker Create Project
Utility to Dockerize your applications using best practices to define your Dockerfile and Docker entry point.

```bash
$ docker run -it fiunchinho/docker-create-project

Your email: something@email.com
Your full name: Alice Wonderland
Does the container runs Java? [False] 
Which file/folder needs to be copied to the container? It'll be copied into '/code' [.] 
Which port do you want to expose? [No ports exposed] 
Do you need an entrypoint to do stuff before running the app? [False] 
Which command needs to be executed to start your application? Your app lives in '/code' python /code/dockercreateproject/create.py
System dependencies (f.e python=2.7.11-r3 py-pip=7.1.2-r0): python=2.7.11-r3 py-pip=7.1.2-r0
App dependencies command (f.e pip install -r requirements.txt): [False] pip install -r requirements.txt

You can build your container running the following command: 
docker build \ 
    --build-arg git_repository=`git config --get remote.origin.url` \ 
    --build-arg git_branch=`git rev-parse --abbrev-ref HEAD` \ 
    --build-arg git_commit=`git rev-parse HEAD` \ 
    --build-arg built_on=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \ 
    -t your_image .
```