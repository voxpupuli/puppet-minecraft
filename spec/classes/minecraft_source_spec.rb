# frozen_string_literal: true

require 'spec_helper'

describe 'minecraft::source' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let :pre_condition do
        'include ::minecraft'
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('minecraft::source') }

        it 'downloads the server' do
          is_expected.to contain_archive('minecraft_server').with(ensure: 'present',
                                                                  path: '/opt/minecraft/minecraft_server.jar',
                                                                  user: 'minecraft',
                                                                  source: 'https://s3.amazonaws.com/Minecraft.Download/versions/1.7.4/minecraft_server.1.7.4.jar')

          is_expected.to contain_archive('minecraft_server').that_requires('User[minecraft]')
        end

        it 'enforces ownership on server file' do
          is_expected.to contain_file('/opt/minecraft/minecraft_server.jar').with(owner: 'minecraft',
                                                                                  group: 'minecraft',
                                                                                  mode: '0644')

          is_expected.to contain_file('/opt/minecraft/minecraft_server.jar').that_requires(['User[minecraft]',
                                                                                            'Group[minecraft]',
                                                                                            'Archive[minecraft_server]'])
        end
      end
    end
  end
end
