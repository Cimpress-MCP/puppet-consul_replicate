require 'spec_helper'

describe 'consul_replicate::monitoring::sensu', :type => :module do

  let :pre_condition do
    "class { 'consul_replicate':
      monitoring  => true,
      config_hash => {
        'consul' => '127.0.0.1:8500',
        'prefix' => [
          'source' => 'global@dc1'
        ]
      }
    }"
  end

  context 'monitoring::sensu' do

    it { should contain_class('consul_replicate::monitoring::sensu') }
    it { should contain_file('Ensure check-procs.rb is present').with_path('/etc/sensu/plugins/processes/check-procs.rb') }
    it { should contain_file('/etc/sensu/conf.d/consul_replicate_config.json') }

  end

end
