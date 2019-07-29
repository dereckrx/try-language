require File.expand_path('../helper', __FILE__)

# require 'helper'
require 'regular'

describe 'regular' do
  it('what time is it') do
    assert_equal Regular.hello, 'regular time'
  end
end


