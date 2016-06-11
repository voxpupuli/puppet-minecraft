require 'spec_helper'

describe 'minecraft::source', :type => :class do
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

  it { is_expected.to compile }
  it { is_expected.to contain_class('minecraft::source') }
  it 'runs with defaults' do
  end
  context 'with defaults' do
    it 'downloads the server' do
      is_expected.to contain_archive('minecraft_server').with({
        :ensure => 'present',
        :path   => '/opt/minecraft/minecraft_server.jar',
        :user   => 'minecraft',
        :source => 'https://s3.amazonaws.com/Minecraft.Download/versions/1.7.4/minecraft_server.1.7.4.jar'})
      is_expected.to contain_archive('minecraft_server').that_requires('User[minecraft]')
    end
    it 'enforces ownership on server file' do
      is_expected.to contain_file('/opt/minecraft/minecraft_server.jar').with({
        :owner => 'minecraft',
        :group => 'minecraft',
        :mode  => '0644',
      })
      is_expected.to contain_file('/opt/minecraft/minecraft_server.jar').that_requires('User[minecraft]')
      is_expected.to contain_file('/opt/minecraft/minecraft_server.jar').that_requires('Group[minecraft]')
      is_expected.to contain_file('/opt/minecraft/minecraft_server.jar').that_requires('Archive[minecraft_server]')
    end
  end
end
