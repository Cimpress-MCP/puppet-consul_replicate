puppet-consul_replicate
=======================
[![Latest Version](http://img.shields.io/github/release/Cimpress-MCP/puppet-consul_replicate.svg?style=flat-square)][release]
[![Build Status](http://img.shields.io/travis/Cimpress-MCP/puppet-consul_replicate.svg?style=flat-square)][travis]


[release]: https://github.com/Cimpress-MCP/puppet-consul_replicate/releases
[travis]: https://travis-ci.org/Cimpress-MCP/puppet-consul_replicate



This module installs consul replicate as a service.

The module has been updated to work with consul-replicate 0.2.0. For usage with consul-replicate 0.1.0, use the module tagged on the [release page](https://github.com/Cimpress-MCP/puppet-consul_replicate/releases) on GitHub

More information about usage of consul-replicate can be found [here](https://github.com/hashicorp/consul-replicate)

Usage
-----

At minimum, the src of the datacenter must be provided.

```puppet
class { 'consul_replicate':
	config_hash => {
		consul => '127.0.0.1:8500',
		prefix => {
			source => 'global@dc1'
		}
	}
}
```

This module supports using hiera for populating `config_hash`. Additionally, there is support for populating the `config_hash` partially via `hiera_config` in class instantiation and via hiera on the same puppet run. However, in that case you would have to use `hiera_config_hash` in your hiera YAML file in order for both hashes to get merged.

### Multi-prefix support

As of 0.2.0, multi-destination from the same source and multi-prefix is supported via an array of hashes.

```puppet
class { 'consul_replicate':
	config_hash => {
		consul => '127.0.0.1:8500',
		prefix => [
			{
				source => 'global@dc1',
			},
			{
				source      => 'global@dc2',
				destination => 'default'
			},
			{
				source      => 'global@dc3',
				destination => 'foo'
			},
			{
				source      => 'global@dc3',
				destination => 'bar'
			}
		]
	}
}
```

### Monitoring

This module includes basic sensu checks for monitoring.

What this module affects
------------------------

* Installs a consul-replicate daemon
* Creates a user and group specific to the service (Default: `creplicate`)
* Manages the service via upstart

Dependencies
------------

Since consul-replicate requires a consul agent to be running, the service that this module creates assumes that a consul agent is running on the machine.

The module also depends on a [puppet-stdlib](https://github.com/puppetlabs/puppetlabs-stdlib) 0.4.x or above.

Compatibility
-------------

This module is tested on Ubuntu 14.04 x64.
