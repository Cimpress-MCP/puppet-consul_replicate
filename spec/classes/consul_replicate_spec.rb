require 'spec_helper'

describe 'consul_replicate' do

  Puppet[:parser] = 'future'

  RSpec.configure do |c|
    c.default_facts = {
      :architecture    => 'amd64',
      :operatingsystem => 'Ubuntu',
      :lsbdistrelease  => '14.04',
    }
  end

  let :default_params do {
    :config_hash => {
      'consul' => "127.0.0.1:8500",
      'prefix' => {
        'source' => "global@dc1"
      }
    }
  }
  end

  context 'on an unsupported arch' do
    let(:facts) {{ :architecture => 'bogus' }}
    let(:params) do
      default_params
    end

    it { expect { should compile }.to raise_error(/Unsupported kernel architecture:/) }
  end

  context 'on an unsupported operating system' do
    let(:facts) {{ :operatingsystem => 'bogus' }}
    let(:params) do
      default_params
    end

    it { expect { should compile }.to raise_error(/Unsupported operating system:/) }
  end

  context 'when not specifying config' do
    it { expect { should compile }.to raise_error(/Must pass config_hash to Class\[Consul_replicate\]/) }
  end

  context 'by default, a user and group should be installed' do
    let(:params) do
      default_params
    end

    it { should contain_user('creplicate').with(:ensure => :present) }
    it { should contain_group('creplicate').with(:ensure => :present) }
  end

  context 'when trying to download the binary to the system' do
    let(:params) do
      default_params
    end

    it { should contain_exec('Download consul-replicate binary') }

    it { should contain_file('/usr/local/bin/consul-replicate-0.2.0') }
    it { should contain_file('/usr/local/bin/consul-replicate') }
  end

  context 'when trying to extract the binary to the system' do
    let(:params) do
      default_params
    end

    it{ should contain_exec('Extract consul-replicate binary') }
    it{ should contain_file('/etc/consul_replicate/config.json')}
  end

  context 'on any supported operating system' do
    let(:params) do
      default_params
    end

    it { should contain_class('consul_replicate::params') }

    it { should contain_class('consul_replicate::install') }
    it { should contain_class('consul_replicate::run_service').that_subscribes_to('consul_replicate::install') }
    it { should contain_class('consul_replicate').that_requires('consul_replicate::run_service') }

    it { should contain_service('consul-replicate') }

  end

  context 'on Ubuntu 14.04 base OS' do
    let(:params) do
      default_params
    end

    it { should contain_file('/etc/init/consul-replicate.conf').with_content(/exec consul-replicate/) }
    it { should contain_file('/etc/init.d/consul-replicate') }
  end

end
