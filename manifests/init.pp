class consul_replicate (
  $addr         = '',
  $dst_prefix   = '',
  $lock         = '',
  $prefix       = '',
  $service      = '',
  $src,
  $status       = '',
  $token        = '',
  $bin_dir      = $consul::params::bin_dir,
  $version      = $consul::params::version,
  $download_url = $consul::params::download_url,
  $user         = 'creplicate',
  $group        = 'creplicate',
) inherits consul_replicate::params {

  $options_hash  = {
    addr        => $addr,
   'dst-prefix' => $dst_prefix,
    lock        => $lock,
    prefix      => $prefix,
    service     => $service,
    src         => $src,
    status      => $status,
    token       => $token,
  }
  
  # Build options string
  $options = param_builder($options_hash)

  class { 'consul_replicate::install': } ~>
  class { 'consul_replicate::run_service': } ->
  Class['consul_replicate']
}