
require "test_helper"

class JapaneseTest < Minitest::Test
  def test_normalize_parentheses
    ## 基本パターン
    assert_equal "あいえうえ(xxx)", RubyToys::Japanese.format_parentheses("あいえうえ （ xxx ）")
    assert_equal "foo(bar baz)qux", RubyToys::Japanese.format_parentheses("foo （  bar baz ） qux")
    assert_equal "hello(world)", RubyToys::Japanese.format_parentheses("hello( world ) ")
    assert_equal "スペース(x)あり", RubyToys::Japanese.format_parentheses("スペース　（　x　）あり")

    ## ネスト
    assert_equal "ネスト(内側(something))のテスト", RubyToys::Japanese.format_parentheses("ネスト（内側（  something  ））のテスト")

    ## 括弧がない場合
    assert_equal "no parentheses", RubyToys::Japanese.format_parentheses("no parentheses")

    ## エッジケース
    assert_equal "(start)", RubyToys::Japanese.format_parentheses("（ start ）")
    assert_equal "end)", RubyToys::Japanese.format_parentheses("end）")
    assert_equal "(middle)", RubyToys::Japanese.format_parentheses("（middle）")
  end

  def test_format_comma
    assert_equal "これは、テストです。", RubyToys::Japanese.format("これは, テストです。")
    assert_equal "複数、の、カンマ、を、処理します。", RubyToys::Japanese.format("複数,の,カンマ,を,処理します。")
    assert_equal "スペース、も、全角スペース、も対応。", RubyToys::Japanese.format("スペース , も 、 全角スペース　,も対応。")
    assert_equal "カンマなしの文章。", RubyToys::Japanese.format("カンマなしの文章。")
  end
end