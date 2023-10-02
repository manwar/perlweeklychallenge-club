require 'minitest/autorun'
require_relative 'ch-2'

# frozen_string_literal: true

class Ch2Test < Minitest::Test
  def test_example_1
    assert_equal 3, solve([1, 5, 0, 3, 5])
  end
  
  def test_example_2
    assert_equal 0, solve([0])
  end
  
  def test_example_3
    assert_equal 4, solve([2, 1, 4, 0, 3])
  end
end
