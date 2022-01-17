# frozen_string_literal: true

require 'spec_helper'

describe 'minecraft' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults for all parameters' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_group('minecraft').with_system(true) }
        it { is_expected.to contain_user('minecraft').with_system(true) }
        it { is_expected.to contain_file('server.properties').with_content(%r{^rcon\.password=$}) }
        it { is_expected.to contain_file('server.properties').with_content(%r{^rcon\.port=25575$}) }

        context 'with all parameters set' do
          let(:params) do
            {
              rcon_password: 'foobar',
              rcon_port: 1234
            }
          end

          it { is_expected.to contain_file('server.properties').with_content(%r{^rcon\.password=foobar$}) }
          it { is_expected.to contain_file('server.properties').with_content(%r{^rcon\.port=1234$}) }
        end
      end
    end
  end
end
