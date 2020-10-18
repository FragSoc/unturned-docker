<center>
    <a href="https://store.steampowered.com/app/304930/Unturned/">
        <img width=100% src="https://cdn.cloudflare.steamstatic.com/steam/apps/304930/header.jpg?t=1590451726"/>
    </a>
    <br/>
    <img alt="Travis (.com)" src="https://img.shields.io/travis/com/FragSoc/unturned-docker?style=flat-square">
    <img alt="GitHub" src="https://img.shields.io/github/license/FragSoc/unturned-docker?style=flat-square">
</center>

---

A [Docker](https://www.docker.com/) image to run a dedicated server for [Unturned](https://store.steampowered.com/app/304930/Unturned/).

## Usage

An example sequence could be:

```bash
docker build -t unturned .
docker run -d \
  -p 27015:27015 \
  -p 27016:27016 \
  -p 27017:27017 \
  -p 27015:27015/udp \
  -p 27016:27016/udp \
  -p 27017:27017/udp \
  -v $PWD/unturned_config:/config \
  unturned
```

### Volumes

The image exposes one volume at `/config` for the server's configuration files.

### Ports

The image exposes all the following ports over TCP and UDP:

- `27015`
- `27016`
- `27017`

### Build Arguments

- `UID` sets the user ID value of the user the server will run under, defaults to `999`.
  You might want to override this for easier directory permission management.

## Licensing

The few files in this repo are licensed under the AGPL-3.

However, Unturned is proprietary software licensed by [Smartly Dressed Games](https://smartlydressedgames.com/); no credit is taken for the software in this image.
