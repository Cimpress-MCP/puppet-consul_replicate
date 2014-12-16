# puppet-consul_replicate

## Overview

This module installs consul replicate as a service. Check README.md for details and OS support.

More information about usage of consul-replicate can be found on https://github.com/hashicorp/consul-replicate

## Usage

At minimum, the src of the datacenter must be provided.

```puppet
class { 'consul_replicate':
	src => 'dc1'
}
```

## What this module affects

* Installs a consul-replicate daemon
* Creates a user and group specific to the service (Default: `creplicate`)
* Manages the service via upstart

## Dependencies

Since consul-replicate requires a consul agent to be running, the service that this module creates assumes that a consul agent is running on the machine

## Compatibility

This module is tested on Ubuntu 14.04 x64. 

