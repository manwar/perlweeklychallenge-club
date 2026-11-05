#!/usr/bin/env ruby

require "minitest/autorun"

def string_difference(words)
  keys = words.map do |w|
    ords = w.bytes
    (0...ords.size-1).map {|i| ords[i+1] - ords[i]}.join(",")
  end
  counts = Hash.new(0)
  keys.each {|k| counts[k] += 1}
  words.each_with_index do |w,i|
    return w if counts[keys[i]] == 1
  end
  -1
end

class StringDifferenceTest < Minitest::Test
  def test_example_1
    assert_equal "zy", string_difference(["ab","bc","cd","zy"])
  end

  def test_example_2
    assert_equal "azy", string_difference(["cba","fed","azy"])
  end

  def test_example_3
    assert_equal "pop", string_difference(["pop","ada","beb","cfc"])
  end

  def test_example_4
    assert_equal "aaba",string_difference(["aaaa","zzzz","mmmm","aaba"])
  end

  def test_example_5
    assert_equal "azbz",string_difference(["aceg","bdfh","cegi","azbz"])
  end
end

