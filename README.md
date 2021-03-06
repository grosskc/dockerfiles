# Quickstart

- Install docker for [Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows/) or [Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac) or a flavor of Linux ([Ubuntu](https://docs.docker.com/engine/install/ubuntu/#installation-methods), [Fedora](https://docs.docker.com/engine/install/fedora/), [CentOS](https://docs.docker.com/engine/install/centos/)).

- Clone the modified docker [GitHub repository](https://github.com/grosskc/dockerfiles) and build the Docker image. You'll need `git` and `make` in order to complete this step. This takes awhile and is a one-time step.

  ```bash
  git clone https://github.com/grosskc/dockerfiles.git
  cd dockerfiles
  make rs-pandoc
  ```

- Alternatively, the step above can be bypassed by installing the following docker image, making it available for use on your computer.

  ```bash
  # make it available to docker
  docker load --input /path/to/ownCloud/RS-EOIR-Group/Templates/dockerfiles/rs-pandoc-latest.tar.gz
  ```

- Open your terminal application and change to the directory in which your markdown file lives. You can use the integrated terminal within VS Code, for example.

- Now run the docker environment, making your current working directory available in the Docker's `/data` folder. This will launch your shell into a linux environment with the bash command line interpreter.

  - At a unix / linux terminal

    ```bash
    docker run --rm --volume "`pwd`:/data" -it rs/pandoc
    ```

  - On Windows in a PowerShell terminal

    ```bash
    docker run --rm --volume ${PWD}:/data -it rs/pandoc
    ```

- You should now be able to compile markdown documents in your current directory to PDF files and HTML files using the pandoc executable within this Docker environment. (This environment also comes with a fairly complete LaTeX distribution installed for converting MD to PDF.)

  ```bash
  pandoc file.md -o file.pdf
  ```

- Additionally, you can use the company template for reports or self-contained HTML files. Helper functions makes this easy:

  ```bash
  # make PDF report
  /root/bin/pandoc_report.sh file.md

  # make self-contained HTML document
  /root/bin/pandoc_html.sh file.md
  ```

- Below is a screenshot of what successfully converting this README.md file should look like

![Screenshot of converting this README.md into an HTML file.](assets/Screenshot.png)

For more information on how to build a pandoc docker image, see the official [Docker repo for Pandoc](https://github.com/pandoc/dockerfiles).
