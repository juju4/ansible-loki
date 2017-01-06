require 'serverspec'

# Required by serverspec
set :backend, :exec


describe package('python-virtualenv') do
  it { should be_installed }
end

describe file('/tmp/ir-bin/Loki/loki.py') do
  it { should be_owned_by 'root' }
  it { should be_executable }
end

