class consul_replicate (
  $addr         = '127.0.0.1:8500',
  $dst_prefix   = 'global/',
  $lock         = 'service/consul-replicate/leader',
  $prefix       = '',
  $service      = 'consul-replicate',
  $src,
  $status       = 'service/consul-replicate/status',
  $token        = '',
  $bin_dir      = $consul::params::bin_dir,
  $version      = $consul::params::version,
  $download_url = $consul::params::download_url,
  $user         = 'creplicate',
  $group        = 'creplicate',
) inherits consul_replicate::params {

  $options_hash  = {
    addr       => $addr,
    dst_prefix => $dst_prefix,
    lock       => $lock,
    prefix     => $prefix,
    service    => $service,
    src        => $src,
    status     => $status,
    token      => $token,
  }
  
  # Build options string
  $options = param_builder($options_hash)

  class { 'consul_replicate::configure': } ->
  class { 'consul_replicate::service': } ~>
  class { 'consul_replicate::run_service': } ->
  Class['consul_replicate']
}