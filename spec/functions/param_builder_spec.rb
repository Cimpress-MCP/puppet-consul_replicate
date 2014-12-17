require 'spec_helper'

describe 'param_builder' do
  let(:options_hash) {{
    :addr       => '127.0.0.1:8500',
    :'dst-prefix' => 'global/',
    :lock       => 'service/consul-replicate/leader',
    :prefix     => '',
    :service    => 'consul-replicate',
    :src        => 'dc1',
    :status     => 'service/consul-replicate/status',
    :token      => ''
  }}


  it { should run.with_params(options_hash).and_return("-addr 127.0.0.1:8500 -dst-prefix global/ -lock service/consul-replicate/leader -service consul-replicate -src dc1 -status service/consul-replicate/status") }
end