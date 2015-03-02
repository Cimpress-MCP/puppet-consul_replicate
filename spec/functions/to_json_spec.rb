require 'spec_helper'

describe 'to_json' do
  let(:config_hash) {{
    :consul    => '127.0.0.1:8200',
    :token     => 'abcd1234',
    :retry     => '10s',
    :max_stale => '10m',
    :prefix    => {
      source => 'global@nyc1'
    },
  }}

  expected_json = <<-EOS
  {
    "consul": "127.0.0.1:8200",
    "token": "abcd1234",
    "retry": "10s",
    "max_stale": "10m",
    "prefix": {
      "source": "global@nyc1"
    }
  }
  EOS

  it { should run.with_params(config_hash).and_return(expected_json) }
end
