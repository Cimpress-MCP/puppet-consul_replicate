module Puppet::Parser::Functions
  newfunction(:param_builder, :type => :rvalue) do |args|
    hash = args[0]
    param = ''

    hash.each do |key, val|
      if not val.empty?
        param += "-#{key} #{val} "
    end

    return param
  end
end