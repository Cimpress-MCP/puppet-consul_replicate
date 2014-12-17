module Puppet::Parser::Functions
  newfunction(:param_builder, :type => :rvalue) do |args|
    hash = args[0]
    param = ''

    hash.each do |key, val|
      if not val.empty? then
        param += "-#{key} #{val} "
      end
    end

    return param
  end
end