require 'spec_helper'

describe 'minecraft::plugin', :type => :define do
  let :pre_condition do
    'include ::minecraft'
  end
  let :facts do
    {
      :osfamily               => 'debian',
      :operatingsystem        => 'ubuntu',
      :operatingsystemrelease => '14.04',
      :lsbdistcodename        => 'trusty',
      :id                     => 'root',
      :concat_basedir         => '/dne',
      :path                   => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      :kernel                 => 'Linux',
    }
  end

  let :title do
    'dynmap'
  end

  let :params do
    {
      :source => 'http://dev.bukkit.org/media/files/757/982/dynmap-1.9.1.jar'
    }
  end
  it { is_expected.to compile }
  it 'downloads the plugin' do
    is_expected.to contain_archive('dynmap').with({
      :ensure => 'present',
      :path   => '/opt/minecraft/plugins/dynmap.jar',
      :user   => 'minecraft',
      :source => 'http://dev.bukkit.org/media/files/757/982/dynmap-1.9.1.jar'})
  end

  it 'depends on plugin dir' do
    is_expected.to contain_archive('dynmap').that_requires('File[/opt/minecraft/plugins]')
  end

  it 'depends on minecraft user' do
    is_expected.to contain_archive('dynmap').that_requires('User[minecraft]')
  end

  it 'enforces plugin ownership' do
    is_expected.to contain_file('/opt/minecraft/plugins/dynmap.jar').with({
      :ensure => 'file',
      :owner  => 'minecraft',
      :group  => 'minecraft',
      :mode   => '0644',
    }).that_requires('Archive[dynmap]')
  end
end
