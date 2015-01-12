class consul_replicate::run_service {
  service { 'consul-replicate':
    ensure => 'running',
    enable => true,
  }
}
