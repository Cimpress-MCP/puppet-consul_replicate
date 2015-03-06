# See README.md for details
class consul_replicate::populate_hash {
  $merged_config_hash = merge(hiera_hash('consul_replicate::hiera_config_hash', {}), $consul_replicate::config_hash)

  # Check for consul value in the merged_config_hash
  if !has_key($merged_config_hash, 'consul') {
    fail( 'consul value must be provided in config_hash or hiera_config_hash' )
  }

  # Check for prefix value is in the merged_config_hash
  if !has_key($merged_config_hash, 'prefix') {
    fail( 'prefix value must be provided in config_hash or hiera_config_hash' )
  }
}
