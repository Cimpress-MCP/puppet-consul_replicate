class consul_replicate::configure {
  
  exec { "Stop consul-replicate service if it's running":
    command => "sudo service consul-replicate stop",
    path    => '/usr/bin:/usr/local/bin:/bin',
    onlyif  => "sudo service consul-replicate | grep running",
  } ->

  exec {"Download consul-replicate binary":
    command     => "sudo wget -q --no-check-certificate ${consul_replicate::download_url} -O ${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version} || sudo rm -f ${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}",
    path        => '/usr/bin:/usr/local/bin:/bin'
  }->

  exec {"Check for binary presence":
    command => "/usr/bin/test -e ${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}",
    path    => '/usr/bin:/usr/local/bin:/bin',
  } ->

  file { "${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}":
    ensure => file,
    owner => 'root',
    group => 'root',
    mode   => '0555',
  } ->

  file { "${consul_replicate::bin_dir}/consul-replicate":
    ensure => link,
    target => "${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}",
    require => File["${consul_replicate::bin_dir}/consul-replicate-${consul_replicate::version}"],
  }

  group { $fsconsul::group:
    ensure => present
  }

  user { $fsconsul::user:
    ensure  => present,
  }
}