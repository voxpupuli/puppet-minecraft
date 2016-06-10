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
    #it is_expected.to contain_class('archive')
  end
end
