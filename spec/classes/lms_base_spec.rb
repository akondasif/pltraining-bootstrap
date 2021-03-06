require 'spec_helper'

describe "bootstrap::profile::lms_base" do
  let(:node) { 'test.example.com' }

  let(:facts) { {
    :osfamily                  => 'RedHat',
    :operatingsystem           => 'CentOS',
    :operatingsystemrelease    => '7.2.1511',
  } }

  it { is_expected.to compile.with_all_deps }

end
