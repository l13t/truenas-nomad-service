# truenas-nomad-service

- [truenas-nomad-service](#truenas-nomad-service)
  - [Introduction](#introduction)
  - [Prerequisites](#prerequisites)
  - [How to start](#how-to-start)
  - [TODO](#todo)

## Introduction

This repo contains manifest and instructions on how to run [HashiCorp Nomad](https://www.nomadproject.io/) in [TrueNAS](https://www.truenas.com/).

## Prerequisites

- Docker engine should be enabled in your TrueNAS installation. It will be automatically be enabled once you try to create a new application.
- Also you'll need either to create `/var/lib/nomad` folder, or create it somewhere and symlink it to that path. Maybe it's possible to do from TrueNAS App YAML template, but this app was developed only because I want to keep using Nomad to run my containers.
- Create folder that will contain config file for Nomad. It will be mounted to `/etc/nomad`. Example config file you can find in this repository: [nomad.hcl](/nomad.hcl)

## How to start

1. Go to Apps section
2. Click `Discover apps` and than three dot button next to `Custom App` button, select `Install from YAML` option
3. Copy content from [nomad.truenas.yaml](/nomad.truenas.yaml) and past it to editor window
4. Set name for your application and click save
5. Now after Nomad deamon finish start, you should be able to reach Nomad from you browser with URL like: [http://<your-truenas-ip-or-dns>:4646](http://<your-truenas-ip-or-dns>:4646)
6. Add creation of symlink to `/var/lib/docker` on system start. Go to `System` => `Advanced Settings`. In `Init/Shutdown Scripts` add `Post-Init` command:

   ```shell
   ln -s /mnt/.ix-apps/docker /var/lib/docker
   ```

## TODO

- [ ] Automate config creation
- [x] Automate folders binding
- [ ] Include sample config file into package
- [ ] Set icon for the application and extend its description
