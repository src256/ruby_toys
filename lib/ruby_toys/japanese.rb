module RubyToys
  class Japanese

    # 全角括弧を半角に変換し、括弧の前後の空白を削除する
    def self.format_parentheses(str)
      s = str.gsub('（', '(').gsub('）', ')')
      sp = "[\\s\\u3000]"
      s = s.gsub(/#{sp}+(?=\()/, '')
      s = s.gsub(/(?<=\))#{sp}+/, '')
      s = s.gsub(/(?<=\()#{sp}+/, '')
      s = s.gsub(/#{sp}+(?=\))/, '')
      s
    end

    ## 全角カンマの前後の空白を削除し、半角カンマを全角カンマに置換する
    def self.format_comma(str)
      # カンマの後の空白（半角・全角）を削除して、カンマを全角に置換
      sp = "[\\s\\u3000]"
      # 半角カンマの前後空白を削除して全角カンマに置換
      str = str.gsub(/#{sp}*,#{sp}*/, '、')
      # 既存の全角カンマの前後空白も削除
      str = str.gsub(/#{sp}*、#{sp}*/, '、')
      str
    end

    def self.format(str)
      str = format_parentheses(str)
      str = format_comma(str)
      str
    end

    # KUTEN = "、"
    # TOUTEN = "。"
    # NAKAGOU = "・"
    # KAGIKAKKO_START = "「"
    # KAGIKAKKO_END = "」"
    # NAKAGOU_REPLACEMENT = "･" # 半角中黒
    #
    # # コンストラクタ
    # def initialize(text)
    #   @text = text
    # end
    #
    # # フォーマットを実行して結果を返す
    # def format
    #   formatted_text = @text.dup
    #
    #   # 全角スペースを半角スペースに変換
    #   formatted_text.gsub!(/　/, ' ')
    #
    #   # 連続するスペースを1つにまとめる
    #   formatted_text.gsub!(/ {2,}/, ' ')
    #
    #   # 句点と読点の前後のスペースを削除
    #   formatted_text.gsub!(/\s*#{KUTEN}\s*/, KUTEN)
    #   formatted_text.gsub!(/\s*#{TOUTEN}\s*/, TOUTEN)
    #
    #   # 中黒の前後のスペースを削除し、半角中黒に置換
    #   formatted_text.gsub!(/\s*#{NAKAGOU}\s*/, NAKAGOU_REPLACEMENT)
    #
    #   # 括弧の前後のスペースを削除
    #   formatted_text.gsub!(/\s*#{KAGIKAKKO_START}\s*/, KAGIKAKKO_START)
    #   formatted_text.gsub!(/\s*#{KAGIKAKKO_END}\s*/, KAGIKAKKO_END)
    #
    #   # 文末に句点がない場合は追加
    #   unless formatted_text.end_with?(TOUTEN)
    #     formatted_text += TOUTEN
    #   end
    #
    #   formatted_text
    # end
  end
end