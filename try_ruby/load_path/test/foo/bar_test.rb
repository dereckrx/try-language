require File.expand_path('../../helper', __FILE__)
#require 'helper'
require 'foo/bar'

require 'minitest/autorun'

describe 'X' do
  before do

  end

  it 'foo bar' do
    assert_equal 1, Bar.bar
  end
end