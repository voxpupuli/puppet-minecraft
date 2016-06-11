require 'spec_helper'

describe 'minecraft::plugin', type: :define do
  let :pre_condition do
    'include ::minecraft'
  end
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end
      let :params do
        {
          source: 'http://dev.bukkit.org/media/files/757/982/dynmap-1.9.1.jar'
        }
      end

      let :title do
        'dynmap'
      end

      it { is_expected.to compile.with_all_deps }
      it 'downloads the plugin' do
        is_expected.to contain_archive('dynmap').with(ensure: 'present',
                                                      path: '/opt/minecraft/plugins/dynmap.jar',
                                                      user: 'minecraft',
                                                      source: 'http://dev.bukkit.org/media/files/757/982/dynmap-1.9.1.jar')
      end

      it 'depends on plugin dir' do
        is_expected.to contain_archive('dynmap').that_requires('File[/opt/minecraft/plugins]')
      end

      it 'depends on minecraft user' do
        is_expected.to contain_archive('dynmap').that_requires('User[minecraft]')
      end

      it 'enforces plugin ownership' do
        is_expected.to contain_file('/opt/minecraft/plugins/dynmap.jar').with(ensure: 'file',
                                                                              owner: 'minecraft',
                                                                              group: 'minecraft',
                                                                              mode: '0644').that_requires('Archive[dynmap]')
      end
    end
  end
end
