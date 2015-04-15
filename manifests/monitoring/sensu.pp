# See README.md for details
class consul_replicate::monitoring::sensu {

  if !defined(Package['sensu']) {
    package { 'sensu':
      ensure => installed
    }
  }

  file { 'Ensure check-procs.rb is present':
    ensure  => file,
    path    => '/etc/sensu/plugins/processes/check-procs.rb',
    require => Package['sensu']
  } ->

  file { '/etc/sensu/conf.d/consul_replicate_config.json':
    ensure  => file,
    notify  => Service['sensu-client'],
    content => template('consul_replicate/consul_replicate_config.json.erb')
  }
}
