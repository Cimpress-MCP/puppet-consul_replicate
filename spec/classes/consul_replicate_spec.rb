require 'spec_helper'

describe 'consul_replicate' do
  RSpec.configure do |c|
    c.default_facts = {
      :architecture    => 'amd64',
      :operatingsystem => 'Ubuntu',
      :lsbdistrelease  => '14.04',
    }
  end

  context 'on an unsupported arch' do
    let(:facts) {{ :architecture => 'bogus' }}
    let(:params) {{
      :src => 'dc1'
    }}
    it { expect { should compile }.to raise_error(/Unsupported kernel architecture:/) }
  end

  context 'on an unsupported operating system' do
    let(:facts) {{ :operatingsystem => 'bogus' }}
    let(:params) {{
      :src => 'dc1'
    }}
    it { expect { should compile }.to raise_error(/Unsupported operating system:/) }
  end

  context 'when not specifying a src' do
    it { expect { should compile }.to raise_error(/Must pass src/) }
  end

  context 'on Ubuntu 14.04 x64' do
    let(:params) {{
      :src => 'dc1'
    }}

    it { should contain_class('consul_replicate::params') }   

    it { should contain_class('consul_replicate::install') }
    it { should contain_class('consul_replicate::run_service').that_subscribes_to('consul_replicate::install') }

    it { should contain_service('consul-replicate') }
  end

  context "by default, a user and group should be installed" do
    let(:params) {{
      :src => 'dc1'
    }}
    
    it { should contain_user('creplicate').with(:ensure => :present) }
    it { should contain_group('creplicate').with(:ensure => :present) }
  end

end