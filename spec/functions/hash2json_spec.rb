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
  let(:config_multiprefix) {{
    'prefix'    => [
      {
            'destination' => 'local/nyc1',
            'source' => 'global@nyc1'
        },
        {
            'destination' => 'local/nyc2',
            'source' => 'global@nyc2'
        }
    ]
  }}

  expected_out1 = <<-EOF.chop
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

  expected_out2 = <<-EOF.chop
{
\t"prefix": [{
\t\t"destination": "local/nyc1",
\t\t"source": "global@nyc1"
\t},{
\t\t"destination": "local/nyc2",
\t\t"source": "global@nyc2"
\t}]
}
EOF

  it { should run.with_params(config_hash).and_return(expected_out1) }
  it { should run.with_params(config_multiprefix).and_return(expected_out2) }
end
