# See README.md for details
class consul_replicate::run_service {
  service { 'consul-replicate':
    ensure => 'running',
    enable => true,
  }
}
