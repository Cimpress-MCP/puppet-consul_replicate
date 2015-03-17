require 'spec_helper'

describe 'hash2json' do
  let(:config_hash) {{
    'consul'    => '127.0.0.1:8200',
    'token'     => 'abcd1234',
    'retry'     => '10s',
    'max_stale' => '10m',
    'prefix'    => {
      'source' => 'global@nyc1'
    },
  }}

expected_json = <<-EOF.chop
{
\t"consul": "127.0.0.1:8200",
\t"max_stale": "10m",
\t"prefix": {
\t\t"source": "global@nyc1"
\t},
\t"retry": "10s",
\t"token": "abcd1234"
}
EOF

  it { should run.with_params(config_hash).and_return(expected_json) }
end
