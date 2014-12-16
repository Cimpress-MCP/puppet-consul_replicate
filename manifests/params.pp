class consul_replicate::params {
  $version = '0.1.0'

  case $::operatingsystem {
    ubuntu: {
      $bin_dir      = '/usr/local/bin'
      $download_url = "https://github.com/hashicorp/consul-replicate/releases/download/v${version}/consul-replicate_linux_${::operatingsystem}" 
    }
    default: { fail("Unsupported operating system: ${::operatingsystem}") }
  }
}