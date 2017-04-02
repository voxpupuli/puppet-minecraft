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
      end
    end
  end
end
