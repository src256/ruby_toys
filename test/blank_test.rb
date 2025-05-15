
require "test_helper"

class BlankTest < Minitest::Test
  using RubyToys::Blank

  def test_that_it_has_a_version_number
    refute_nil ::RubyToys::VERSION
  end

  def test_nil_blank
    assert nil.blank?, 'nil should be blank'
  end

  def test_false_blank
    assert false.blank?, 'false should be blank'
  end

  def test_true_blank
    refute true.blank?, 'true should not be blank'
  end

  def test_empty_string_blank
    assert ''.blank?, 'empty string should be blank'
  end

  def test_whitespace_string_blank
    assert '   '.blank?, 'whitespace-only string should be blank'
  end

  def test_tabs_newlines_string_blank
    assert "\t\n\r".blank?, 'string with tabs and newlines should be blank'
  end

  def test_non_empty_string_blank
    refute 'hello'.blank?, 'non-empty string should not be blank'
  end

  def test_string_with_spaces_and_content_blank
    refute ' hello '.blank?, 'string with spaces and content should not be blank'
  end

  def test_empty_array_blank
    assert [].blank?, 'empty array should be blank'
  end

  def test_non_empty_array_blank
    refute [1, 2].blank?, 'non-empty array should not be blank'
  end

  def test_empty_hash_blank
    assert ({}).blank?, 'empty hash should be blank'
  end

  def test_non_empty_hash_blank
    refute ({ a: 1 }).blank?, 'non-empty hash should not be blank'
  end

  def test_zero_blank
    refute 0.blank?, 'zero should not be blank'
  end

  def test_custom_empty_object_blank
    obj = Class.new { def empty?; true; end }.new
    assert obj.blank?, 'object with empty? returning true should be blank'
  end

  def test_custom_non_empty_object_blank
    obj = Class.new { def empty?; false; end }.new
    refute obj.blank?, 'object with empty? returning false should not be blank'
  end

  def test_nil_present
    refute nil.present?, 'nil should not be present'
  end

  def test_false_present
    refute false.present?, 'false should not be present'
  end

  def test_true_present
    assert true.present?, 'true should be present'
  end

  def test_empty_string_present
    refute ''.present?, 'empty string should not be present'
  end

  def test_whitespace_string_present
    refute '   '.present?, 'whitespace-only string should not be present'
  end

  def test_non_empty_string_present
    assert 'hello'.present?, 'non-empty string should be present'
  end

  def test_empty_array_present
    refute [].present?, 'empty array should not be present'
  end

  def test_non_empty_array_present
    assert [1, 2].present?, 'non-empty array should be present'
  end

  def test_empty_hash_present
    refute ({}).present?, 'empty hash should not be present'
  end

  def test_non_empty_hash_present
    assert ({ a: 1 }).present?, 'non-empty hash should be present'
  end

  def test_zero_present
    assert 0.present?, 'zero should be present'
  end
end