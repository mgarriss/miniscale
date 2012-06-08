# A sample Guardfile
# More info at https://github.com/guard/guard#readme

require 'rb-fsevent'

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
end

