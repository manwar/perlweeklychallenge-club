#! /usr/bin/ruby

def reordernotes(composer, notes, order)
  out = Array.new(order.length, "")
  order.each_with_index do |n, i|
    out[n - 1] = notes[i]
  end
  { composer => out }
end

require 'test/unit'

class TestReordernotes < Test::Unit::TestCase

  def test_ex1
    assert_equal({ 'Mozart' => ['D', 'F', 'A', 'B', 'G', 'E', 'C'] }, reordernotes('Mozart', ['C', 'D', 'E', 'F', 'G', 'A', 'B'], [7, 1, 6, 2, 5, 3, 4]))
  end

  def test_ex2
    assert_equal({ 'Chopin' => ['F', 'E', 'D#', 'D', 'C#', 'C'] }, reordernotes('Chopin', ['C', 'C#', 'D', 'D#', 'E', 'F'], [6, 5, 4, 3, 2, 1]))
  end

  def test_ex3
    assert_equal({ 'Vivaldi' => ['A', 'B', 'C', 'D', 'E'] }, reordernotes('Vivaldi', ['A', 'B', 'C', 'D', 'E'], [1, 2, 3, 4, 5]))
  end

  def test_ex4
    assert_equal({ 'Debussy' => ['C', 'G', 'D', 'A', 'F'] }, reordernotes('Debussy', ['C', 'D', 'F', 'G', 'A'], [1, 3, 5, 2, 4]))
  end

  def test_ex5
    assert_equal({ 'Stravinsky' => ['C#'] }, reordernotes('Stravinsky', ['C#'], [1]))
  end

end
