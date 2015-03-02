# See README.md for details
class consul_replicate::populate_hash {
  $merged_config_hash = merge(hiera_hash('consul_replicate::hiera_config_hash', {}), $consul_replicate::config_hash)
}

if !has_key()
