# puppet-zrepl


## Table of Contents

* [Compatibility](#compatibility)
* [Background](#background)
* [Usage](#usage)
* [Example](#example)
* [Known Issues](#known-issues)
* [Development](#development)
* [Authors](#authors)

----

## Compatibility

Tested with zrepl 0.2.1 and FreeBSD-13

## Background

This module automates the install and configuration of zrepl: [zrepl web site](https://zrepl.github.io/)

### What This Module Affects

## Usage


## Example

**Hiera Data (in yaml)**
```yaml
---
zrepl::global:
  logging:
    - type: "stdout"
      level: "error"
      format: "human"
    - type: "syslog"
      level: "info"
      format: "logfmt"

zrepl::jobs:
  - name: 'sink'
    type: 'sink'
    serve:
      type: tls
      listen: ":8888"
      ca: "/root/etc/zrepl/mycrt.mycrt.crt"
      cert: "/root/etc/zrepl/backup.mycrt.crt"
      key: "/root/etc/zrepl/backup.mycrt.key"
      client_cns:
        - "mycrt.mycrt.com"
    root_fs: "zroot/backup"
```

```yaml
---
zrepl::global:
  logging:
    - type: "stdout"
      level: "error"
      format: "human"
    - type: "syslog"
      level: "info"
      format: "logfmt"

zrepl::jobs:
  - name: 'prod_to_backups'
    type: 'push'
    connect:
      type: tls
      address: "46.4.100.29:8888"
      ca: "/root/etc/zrepl/backup.mycrt.crt"
      cert: "/root/etc/zrepl/mycrt.mycrt.crt"
      key:  "/root/etc/zrepl/mycrt.mycrt.key"
      server_cn: "backup.mycrt.com"
    filesystems: {
        "zroot/ROOT/default/zrepl1": true,
        "zroot/ROOT/default/zrepl3223": true
      }
    snapshotting:
      type: periodic
      prefix: zrepl_
      interval: 20m
    pruning:
      keep_sender:
        - type: not_replicated
        - type: last_n
          count: 5
      keep_receiver:
        - type: grid
          grid: 1x1h(keep=all) | 24x1h | 30x1d | 6x30d
          regex: "^zrepl_"
```

## Known issues


## Development

This project contains tests for [rspec-puppet](http://rspec-puppet.com/).

Quickstart to run all linter and unit tests:

```bash
bundle install --path .vendor/ --without system_tests --without development --without release
bundle exec rake test
```

## Authors

puppet-zrepl is maintained by [Oleg Ginzburg](https://github.com/olevole)
