class consul_replicate::linux::service {

  file { "/etc/init/consul-replicate.conf":
    ensure  => present,
    mode    => '0444',
    owner   => 'root',
    group   => 'root',
    content => template('fsconsul/consul-replicate.upstart.erb')
  } ->
  
  file { "/etc/init.d/consul-replicate":
    ensure => link,
    target => "/lib/init/upstart-job",
    owner  => root,
    group  => root,
    mode   => 0755,
  }
}