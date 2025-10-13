# lib/blank.rb

##
# RubyToys::Blank
#
# Rails の `blank?` / `present?` メソッドを
# 純粋な Ruby 環境でも使えるようにする軽量リファインメント。
#
# @example 使用例
#   require_relative "blank"
#   using RubyToys::Blank
#
#   nil.blank?        # => true
#   false.blank?      # => true
#   "".blank?         # => true
#   "   ".blank?      # => true
#   "abc".blank?      # => false
#   [].blank?         # => true
#   [1, 2].blank?     # => false
#   {}.blank?         # => true
#   {a: 1}.blank?     # => false
#
#   "hello".present?  # => true
#   "".present?       # => false
#
module RubyToys
  ##
  # Refinement モジュール。
  # `using RubyToys::Blank` を宣言したスコープ内で
  # `blank?` / `present?` メソッドが利用可能になります。
  #
  # @note グローバルには影響しません。
  #
  module Blank
    ##
    # オブジェクトが空または偽である場合に true を返します。
    #
    # @return [Boolean]
    refine Object do
      def blank?
        respond_to?(:empty?) ? empty? : !self
      end
    end

    ##
    # オブジェクトが空でない場合に true を返します。
    #
    # @return [Boolean]
    refine Object do
      def present?
        !blank?
      end
    end


    refine NilClass do
      def blank?
        true
      end
    end

    refine FalseClass do
      def blank?
        true
      end
    end

    refine String do
      def blank?
        strip.empty?
      end
    end

    refine Array do
      def blank?
        empty?
      end
    end

    refine Hash do
      def blank?
        empty?
      end
    end
  end
end
