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

end