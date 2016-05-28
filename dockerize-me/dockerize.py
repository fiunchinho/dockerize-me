from jinja2 import Environment, FileSystemLoader
import os


def render(name, email, command, needs_java=False, port=False, app_deps="", dependencies=[], needs_entrypoint=False,
           src="."):
    docker_cmd = command.split(' ').__str__().replace("'", "\"")

    pwd = os.path.dirname(os.path.abspath(__file__))
    j2_env = Environment(loader=FileSystemLoader(pwd), trim_blocks=True, lstrip_blocks=True)
    if needs_entrypoint:
        with open("./docker-entrypoint.sh", "w") as file_handler:
            file_handler.write(j2_env.get_template('docker-entrypoint.j2').render(command=command))

    with open("./Dockerfile", "w") as file_handler:
        file_handler \
            .write(j2_env.get_template('Dockerfile.j2')
                   .render(name=name,
                           email=email,
                           needs_java=needs_java,
                           needs_entrypoint=needs_entrypoint,
                           docker_cmd=docker_cmd,
                           src=src,
                           port=port,
                           deps=dependencies,
                           app_deps=app_deps))


if __name__ == '__main__':
    email = raw_input("What's your email? ")
    name = raw_input("What's your name? ")
    needs_java = raw_input("Does the container run Java? [False] ") or False
    app_folder = raw_input(
        "Which file/folder needs to be copied to the container? It'll be copied into '/code' [.] ") or "."
    exposed_port = raw_input("Which port do you want to expose? [No ports exposed] ")
    entrypoint = raw_input("Do you need an entrypoint to do stuff before running the app? [False] ") == 'True'
    cmd = raw_input("How do you execute your application? The code lives in '/code' ")
    deps = raw_input("System dependencies (f.e python=2.7.11-r3 py-pip=7.1.2-r0): [None] ") or []
    app_deps = raw_input("App dependencies command (f.e pip install -r requirements.txt): [False] ")
    render(
        name=name,
        email=email,
        needs_java=needs_java,
        src=app_folder,
        port=exposed_port,
        needs_entrypoint=entrypoint,
        command=cmd,
        dependencies=deps,
        app_deps=app_deps
    )

    print("If you have selected to use a docker entrypoint, give execution permissions to the docker-entrypoint.sh file before building your image")
    print("You can build your container running the following command: ")
    print("docker build \ ")
    print("--build-arg git_repository=`git config --get remote.origin.url` \ ")
    print("--build-arg git_branch=`git rev-parse --abbrev-ref HEAD` \ ")
    print("--build-arg git_commit=`git rev-parse HEAD` \ ")
    print("--build-arg built_on=`date -u +\"%Y-%m-%dT%H:%M:%SZ\"` \ ")
    print("-t your_image .")
