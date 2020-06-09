# KrugerHeavyIndustries/btmux-docker

[![Source Code][badge-source]][source]
[![Latest Version][badge-release]][release]
[![Software License][badge-license]][license]
[![Docker Build][badge-build]][build]
[![Total Downloads][badge-downloads]][downloads]

[montdidier/btmux][] is a [Docker][] image for [btmux][]

## Fetching or Updating the Docker image

To fetch or update the image, use the docker `pull` command:

```bash
docker pull montdidier/btmux
```

## Running Battletech MUX

To run [montdidier/btmux][] specify a host port to proxy to port 5555 in the running container and map a directory on the docker host to the /var/mux/game directory in the container.

The vanilla example:

```
docker run -d -p 5555:5555 -v "/path/to/host/game:/var/mux/game" montdidier/btmux
```

The first time you run the container, it will copy over an initial minimal game database and configuration files into `/path/to/host/game` on the host system.

### Connecting for the first time

Telnet is readily available or you can use a [MU\* client][clients] to connect to the MUX.

```
telnet localhost 5555
```

The first time you connect to the MUX, you can use `#1` and password `btmuxr0x`. This is the GOD or WIZARD account. If you are planning to expose the MUX to the internet do not forget to change the default password on this account.

```
                                BattletechMUX
                                -------------
                       This site is under construction!                                 
 _____________________________________________________________________________
|connect <name> <password> ...................... Connect to the MUX | WHO    |
|connect "<full name>" <password> ............... Connect to the MUX |        |
|create <name> <password>  .................. Create a New Character |        |
|create "<full name>" <password> ............ Create a New Character | QUIT   |
`-----------------------------------------------------------------------------'
connect #1 btmuxr0x

Connected.
BattleTech MUX 0.7.0-rc4+HUD+HAG+ALG RELEASE svn revision Unversioned directory 'Fly' build #1 on Wed May 27 14:35:39 UTC 2020


MOTD: 
//////////////////////////////////////////////////////////////////////////////
This game is under construction! Tell the staff to update the MOTD on #182.
//////////////////////////////////////////////////////////////////////////////
WIZMOTD: 

Your PAGE LOCK is set. You may be unable to receive some pages.
Last connect was from 172.20.0.1 on Wed May 27 15:26:29 2020.

MAIL: You have no mail.

DATABASE: Purchase Lists(#1821:*Ins)
@password btmuxr0x=newpassword
```

## Contributing

Contributions are welcome. Raise an issue, make a pull request, you know what to do.

## Copyright and License

The [montdidier/btmux][] Docker image is copyright © [Chris Kruger](https://krugerheavyindustries.com)
and licensed for use under the MIT License (MIT). Please see [LICENSE][] for more information.

[montdidier/btmux]: https://hub.docker.com/r/montdidier/btmux
[docker]: https://www.docker.com
[btmux]: https://github.com/KrugerHeavyIndustries/btmux
[clients]: https://en.wikipedia.org/wiki/MUD_client

[badge-source]: http://img.shields.io/badge/source-KrugerHeavyIndustries/btmux--docker-blue.svg?style=flat-square
[badge-release]: https://img.shields.io/github/v/tag/KrugerHeavyIndustries/btmux-docker.svg?sort=semver&style=flat-square
[badge-license]: https://img.shields.io/github/license/KrugerHeavyIndustries/btmux-docker.svg?style=flat-square
[badge-build]: https://img.shields.io/docker/v/montdidier/btmux.svg?sort=semver&style=flat-square
[badge-downloads]: https://img.shields.io/docker/pulls/montdidier/btmux.svg?style=flat-square&colorB=mediumvioletred

[source]: https://github.com/KrugerHeavyIndustries/btmux-docker
[release]: https://github.com/KrugerHeavyIndustries/btmux-docker/releases
[license]: https://github.com/KrugerHeavyIndustries/btmux-docker/blob/master/LICENSE
[build]: https://hub.docker.com/r/montdidier/btmux
[downloads]: https://hub.docker.com/r/montdidier/btmux
