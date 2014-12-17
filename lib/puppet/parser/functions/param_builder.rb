module Puppet::Parser::Functions
  newfunction(:param_builder, :type => :rvalue) do |args|
    hash = args[0]

    return hash.map{ |k, v| "-#{k} #{v}" unless v.empty? }.compact.join(' ')
  end
end