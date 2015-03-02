# See README.md for details
class consul_replicate::install {

  exec { 'Download consul-replicate binary':
    command => "wget -q --no-check-certificate ${consul_replicate::download_url} -O ${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}",
    path    => '/usr/bin:/usr/local/bin:/bin',
    unless  => "test -s ${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}",
    notify  => Service['consul-replicate'],
  } ->

  file { "${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0555',
  } ->

  file { "${consul_replicate::bin_dir}/consul-replicate":
    ensure  => link,
    target  => "${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}",
    require => File["${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}"],
  } ->

  file { '/etc/init/consul-replicate.conf':
    ensure  => present,
    mode    => '0444',
    owner   => 'root',
    group   => 'root',
    content => template('consul_replicate/upstart.erb')
  } ->

  file { '/etc/init.d/consul-replicate':
    ensure => link,
    target => '/lib/init/upstart-job',
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { "${consul::config_dir}/config.json":
    notify  => Service['consul-replicate'],
    content => template('consul_replicate/config.json.erb'),
  }

  group { $consul_replicate::group:
    ensure => present
  }

  user { $consul_replicate::user:
    ensure  => present,
  }
}
