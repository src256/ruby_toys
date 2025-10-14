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
    assert_equal "これは、テストです。", RubyToys::Japanese.format_comma("これは, テストです。")
    assert_equal "複数、の、カンマ、を、処理します。", RubyToys::Japanese.format_comma("複数,の,カンマ,を,処理します。")
    assert_equal "スペース、も、全角スペース、も対応。", RubyToys::Japanese.format_comma("スペース , も 、 全角スペース　,も対応。")
    assert_equal "カンマなしの文章。", RubyToys::Japanese.format_comma("カンマなしの文章。")
  end

  def test_format_word
    assert_equal "abc", RubyToys::Japanese.format_word("abc")
    assert_equal "abc", RubyToys::Japanese.format_word(" abc")
    assert_equal "abc", RubyToys::Japanese.format_word("abc ")
    assert_equal "abc", RubyToys::Japanese.format_word(" abc ")
    assert_equal "abc def", RubyToys::Japanese.format_word("abc def")
    assert_equal "abc def", RubyToys::Japanese.format_word(" abc def ")
    assert_equal "日本語abc日本語", RubyToys::Japanese.format_word("日本語 abc 日本語")
    assert_equal "abc日本語def", RubyToys::Japanese.format_word(" abc 日本語 def ")
    assert_equal "abc  def", RubyToys::Japanese.format_word("  abc  def  ")
    assert_equal "あいうabcえお", RubyToys::Japanese.format_word("あいう  abc  えお")
  end

  def test_format_colon
    assert_equal "項目: これこれこういうもの", RubyToys::Japanese.format_colon("項目：これこれこういうもの")
    assert_equal "項目: これこれこういうもの", RubyToys::Japanese.format_colon("項目 ： これこれこういうもの")
    assert_equal "項目: これこれこういうもの", RubyToys::Japanese.format_colon("項目:これこれこういうもの")
    assert_equal "項目: これこれこういうもの", RubyToys::Japanese.format_colon("項目: これこれこういうもの")
    assert_equal "項目: これこれこういうもの", RubyToys::Japanese.format_colon("項目  ：これこれこういうもの")
    #    assert_equal "項目: これこれこういうもの", RubyToys::Japanese.format_colon("項目　：　これこれこういうもの") # 全角スペース込み
    assert_equal "項目A: B", RubyToys::Japanese.format_colon("項目A: B") # すでに正しい形式
    assert_equal "項目A: B", RubyToys::Japanese.format_colon("項目A:  B") # コロン前の空白削除

    assert_equal "これは, テスト（例: sample）です", RubyToys::Japanese.format_colon("これは, テスト（例：sample）です")
    assert_equal "これは, テスト(例: sample)です", RubyToys::Japanese.format_colon("これは, テスト(例：sample)です")
    assert_equal "これは, テスト(例: sample)です", RubyToys::Japanese.format_colon("これは, テスト(例:sample)です")
    assert_equal "これは、テスト(例: sample)です", RubyToys::Japanese.format_colon("これは、テスト(例：sample)です")
  end

  def test_format
    # 複合パターン
    assert_equal "これは、テスト(例: sample)です", RubyToys::Japanese.format("これは, テスト（例：sample）です")
    # 英単語混在
    assert_equal "日本語english text(注釈)、詳細: 説明", RubyToys::Japanese.format("日本語 english text （注釈）、詳細：説明")
    # 空白多数
    assert_equal "多重空白、括弧(内容): 結果", RubyToys::Japanese.format("  多重  空白  ,  括弧  （ 内容 ） ：  結果")
    # ネスト括弧
    assert_equal "外側(内側(深層))、複雑: 構造", RubyToys::Japanese.format("外側（内側（深層））、複雑：構造")
    # エッジケース: 空文字
    assert_equal "", RubyToys::Japanese.format("")
    # エッジケース: 既に正しい形式
    assert_equal "正しい形式(Already formatted)、そのまま: OK", RubyToys::Japanese.format("正しい形式(Already formatted)、そのまま: OK")
    # エッジケース: 特殊文字のみ
    assert_equal "!?@#&", RubyToys::Japanese.format("!?@#&")
  end
end
