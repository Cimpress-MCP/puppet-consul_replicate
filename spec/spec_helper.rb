require 'puppetlabs_spec_helper/module_spec_helper'
require 'spec_helper'

Puppet[:parser] = 'future'

RSpec.configure do |c|
  c.default_facts = {
    :architecture    => 'amd64',
    :operatingsystem => 'Ubuntu',
    :lsbdistrelease  => '14.04',
  }
end

#Coverage report
at_exit { RSpec::Puppet::Coverage.report! }
