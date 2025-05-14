# coding: utf-8
require 'test_helper'

class UtilsTest < Minitest::Test
  def test_which
    # macの場合
    path = ::RubyToys::Utils::which('more')
    assert_equal('/usr/bin/more', path)
  end
end
