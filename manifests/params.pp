# See README.md for details
class consul_replicate::params {
  $version = '0.2.0'

  case $::architecture {
    'x86_64', 'amd64': { $arch = 'amd64' }
    'i386':            { $arch = '386'   }
    default:           { fail("Unsupported kernel architecture: ${::architecture}") }
  }

  case $::operatingsystem {
    ubuntu: {
      $bin_dir      = '/usr/local/bin'
      $config_dir   = '/etc/consul_replicate'
      $download_url = "https://github.com/hashicorp/consul-replicate/releases/download/v${version}/consul-replicate_linux_${arch}"
    }
    default: { fail("Unsupported operating system: ${::operatingsystem}") }
  }
}
