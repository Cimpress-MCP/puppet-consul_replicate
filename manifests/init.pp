# See README.md for details
class consul_replicate (
  $config_hash  = {},
  $bin_dir      = $consul_replicate::params::bin_dir,
  $config_dir   = $consul_replicate::params::config_dir,
  $version      = $consul_replicate::params::version,
  $download_url = $consul_replicate::params::download_url,
  $user         = $consul_replicate::params::user,
  $group        = $consul_replicate::params::group,
  $monitoring   = $consul_replicate::params::monitoring,
  $sensu_subs   = $consul_replicate::params::sensu_subs,
) inherits consul_replicate::params {

  validate_bool($monitoring)
  validate_array($sensu_subs)

  class { 'consul_replicate::populate_hash': } ->
  class { 'consul_replicate::install': } ~>
  class { 'consul_replicate::run_service': } ->
  Class['consul_replicate']

  if $monitoring == true {
    include ::consul_replicate::monitoring::sensu
    Class['consul_replicate::monitoring::sensu'] -> Class['consul_replicate']
  }
}
