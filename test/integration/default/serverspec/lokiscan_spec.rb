require 'serverspec'

# Required by serverspec
set :backend, :exec

## FIXME! how to use ansible variable or wildcard? Temporary: set dst_path
#describe file('/tmp/{{ dst_path }}/{{ prefix }}-Loki.log') do
#describe file(File.exists?("/tmp/cases/*-incidentreport/*-Loki.log")) do
describe file("/tmp/cases/fqdn-incidentreport/fqdn-Loki.log") do
  it { should be_file }
  its(:content) { should match /SYSTEM SEEMS TO BE CLEAN./ }
  its(:content) { should match /Finished LOKI Scan SYSTEM:/ }
end

describe command('ls -al /tmp/cases/*-incidentreport/*-Loki.log') do
  its(:stdout) { should match /-Loki.log/ }
## FIXME! undefined method `size' for #<Serverspec::Type::Command:0x00000002c09b38>
#  its(:size) { should > 0 }
end

