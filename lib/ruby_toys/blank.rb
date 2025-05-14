# lib/blank.rb
module RubyToys
  module Blank
    refine Object do
      def blank?
        respond_to?(:empty?) ? empty? : !self
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

    refine Object do
      def present?
        !blank?
      end
    end

  end
end
