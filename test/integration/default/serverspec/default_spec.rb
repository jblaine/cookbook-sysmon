require 'spec_helper'

set :os, :family => 'windows'

describe service('sysmon') do
  it { should be_enabled }
  it { should be_running }
end
