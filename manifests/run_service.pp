# See README.md for details
class consul_replicate::run_service {

  if !defined(Service['consul']) {
    service { 'consul':
      ensure => running,
    }
  }

  service { 'consul-replicate':
    ensure  => 'running',
    enable  => true,
    require => Service['consul']
  }
}
