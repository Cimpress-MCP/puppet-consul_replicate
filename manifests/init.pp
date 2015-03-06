# See README.md for details
class consul_replicate (
  $config_hash  = {},
  $bin_dir      = $consul_replicate::params::bin_dir,
  $config_dir   = $consul_replicate::params::config_dir,
  $version      = $consul_replicate::params::version,
  $download_url = $consul_replicate::params::download_url,
  $user         = 'creplicate',
  $group        = 'creplicate',
) inherits consul_replicate::params {

  class { 'consul_replicate::populate_hash': } ->
  class { 'consul_replicate::install': } ~>
  class { 'consul_replicate::run_service': } ->
  Class['consul_replicate']
}
