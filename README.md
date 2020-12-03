# MEGAdav

This Docker image serves over WebDAV your MEGA.nz folders.

## Running with `docker`

With email and password:

```bash
docker run --name megadav -d -p 4443:4443 --env MEGA_EMAIL=myEmail@example.com --env MEGA_PASSWORD=myPassw0rd rogermiret/megadav -p /My-Folder1 -p /My-Folder2
```

If you've got 2FA activated (which you should), then you need to login with a session secret:

```bash
docker run --name megadav -d -p 4443:4443 --env MEGA_SESSION=mySessionSecret rogermiret/megadav -p /My-Folder1 -p /My-Folder2
```

Running `docker logs megadav` will output

```log
Sharing these paths:
Serving via webdav /My-Folder1: http://127.0.0.1:4443/FR5QHCyJ/My-Folder1
Serving via webdav /My-Folder2: http://127.0.0.1:4443/UIAWhSTB/My-Folder2
```

You can now connect to these WebDAV resources using an anonymous login. If your client doesn't have an anonymous login option, any username and password will be validated by the server, so use e.g. `admin` and `password`.

## Running with `docker-compose`

```yaml
version: '2'

services:
  megadav:
    image: rogermiret/megadav:latest
    command: -p /My-Folder1 -p /My-Folder2
    ports:
      - 4443:4443
    environment:
      - MEGA_SESSION=mySuperLongAndSecureMegaSession
```

## How to find my session secret

Run `docker run -it carlosroman/megacmd` and log in using `login --auth-code CODE EMAIL PASSWORD`. After logging in, run `session` to get your secret session.
