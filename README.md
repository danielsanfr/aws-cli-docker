# AWS CLI Docker

![GitHub](https://img.shields.io/github/license/danielsanfr/aws-cli-docker?color=light-green&label=%20&logo=open-source-initiative&logoColor=white) ![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/danielsanfr/aws-cli-docker?sort=semver)

A small `Dockerfile` and `docker-compose.yml` with `awscli` and `awsebcli`. My main use is on the Raspberry Pi.

To correctly install both `awscli` and `awsebcli`, a virtual environment was created for each **CLI** in their respective folders, `/home/awscli/venvs/aws` and `/home/awscli/venvs/eb`. Zsh (and oh-my-zsh) was also installed to facilitate the use of the shell.

## Installation

You need install Docker and if you want a more simple way to use, I recommend docker-compose too.

A good start point to install this tools, is the official documentation on https://docs.docker.com/get-docker/ and https://docs.docker.com/compose/install/

After install Docker you can build the image in your system using:

```bash
$ sudo docker build -t awscli:0.1 .
```

## Configuration

### SSH keys

To use some of the features of `awscli` and `awsebcli` I recommend that you create a volume that points your local SSH keys to the `/home/awscli/.ssh` folder of the container. This is considered in the docker-compose as well as in the command to execute using only the docker.

### Environment Variables

| Name                  | Default   | Description                                                  |
| --------------------- | --------- | ------------------------------------------------------------ |
| AWS_DEFAULT_REGION    | us-east-1 | Specifies the AWS Region to send the request to.             |
| AWS_ACCESS_KEY_ID     | Nothing   | Specifies an AWS access key associated with an IAM user or role. |
| AWS_SECRET_ACCESS_KEY | Nothing   | Specifies the secret key associated with the access key. This is essentially                                             the "password" for the access key. |

## Usage

If you are using docker:

```bash
$ sudo docker run \
    -e AWS_DEFAULT_REGION=us-east-1
    -e AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY> \
    -e AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_KEY> \
    -v /path/to/directory:/home/awscli/.ssh \
    awscli:0.1 \
    zsh
```

If you are using docker-compose, put your environment variables in a `.env` file and execute:

```bash
$ sudo docker-compose run awscli zsh
```

## Author

Daniel San Ferreira da Rocha <daniel.samrocha@gmail.com>

## License

This is free and unencumbered software released into the public domain.