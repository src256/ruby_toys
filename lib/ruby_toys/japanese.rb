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

    # 英単語の前後の空白だけを削除する
    def self.format_word(text)
      # ChatGPTが解決できずGeminiに教えて貰う(英単語を検索する方法ではうまくいかず、日本語文字列を指定する方法)
      # 1. 文字列全体の先頭と末尾の空白を削除（trim）
      trimmed_text = text.strip

      # 2. 英単語以外の文字（ここでは日本語を想定）の直前・直後の空白を削除
      #    - \s* は0回以上の空白文字
      #    - ([\p{Han}\p{Hiragana}\p{Katakana}]+) は日本語の文字（漢字、ひらがな、カタカナ、記号）をキャプチャ
      #    - \1 はキャプチャした日本語の文字に戻す
      cleaned_text = trimmed_text.gsub(/\s*([\p{Han}\p{Hiragana}\p{Katakana}\p{Punctuation}]+)\s*/, '\1')

      # 3. 英語と日本語の間の空白も整えるため、再度全体をtrimする（念のため）
      cleaned_text.strip
    end

    # 全角コロン or 半角コロン（後ろにスペースがない場合も含む）正規化
    def self.format_colon(text)
      text.gsub(/\s*[:\uFF1A]\s*/, ': ')       # コロンの前に空白があれば削除
    end

    def self.format(str)
      #      puts "Input: #{str}"
      # 最初に空白を削除しとかないとformat_colonが正しく動作しないので注意(あとからformat_wordを呼ぶと追加した空白が削除されてしまう)
      str = format_word(str)
      #puts "After word formatting: #{str}"
      str = format_parentheses(str)
      #puts "After parentheses: #{str}"
      str = format_comma(str)
      #puts "After comma: #{str}"
      str = format_colon(str)
      #puts "After colon: #{str}"
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