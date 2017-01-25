require 'serverspec'

# Required by serverspec
set :backend, :exec


describe command('pip freeze') do
  its(:stdout) { should_not match /yara/ }
end

describe command('/tmp/ir-bin/Loki/env/bin/pip freeze') do
  its(:stdout) { should match /yara/ }
  its(:stdout) { should match /argparse/ }
end

