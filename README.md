# OpenSSH container with fixed host keys

Build a Debian container image with OpenSSH using Podman/Buildah.


## Run the image build

To build the image run

```bash
./build-container.sh
```

## Run the container

Exposed ports are
*  22 SSH

Example: Run the container with OpenSSH listening on port 10022 for SSH.

```bash
# alias podman=docker

podman run --name test-ssh --hostname test-ssh -p 10022:22 --detach localhost/test-openssh:latest

podman run --name test-ssh --hostname test-ssh -p 10022:22 --rm -v ~/.ssh/id_ed25519.pub:/root/.ssh/authorized_keys:ro localhost/test-openssh:latest
```


## Safety

Do not run `setup.sh` in your host system.
