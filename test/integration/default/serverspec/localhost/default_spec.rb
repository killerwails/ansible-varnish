require 'spec_helper'

describe 'ansible-varnish::default' do

  describe port(80) do
    it { should be_listening }
  end

  describe port(120) do
    it { should be_listening }
  end

  describe port(6082) do
    it { should be_listening.with('localhost') }
  end

end

describe 'ansible-varnish::install' do

  describe package('varnish') do
    it { should be_installed.by('apt') }
  end

end

describe 'ansible-varnish::configure' do

  describe file('/etc/default/varnish') do
    it { should be_mode 664 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'staff' }
    its(:content) { should match '/templates/etc/default/varnish'}
  end

  describe file('/etc/varnish/default.vcl') do
    it { should be_mode 664 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'staff' }
  end

  describe service('varnish') do
    it { should be_installed }
    it { should be_running }
  end

end
