#! /usr/bin/ruby

def longestabsolutepath(fs)
  components = []
  maxlen = 0
  fs.split("\\n").each do |entry|
    parts = entry.split("\\t")
    depth = parts.size
    while components.size < depth
      components.push(0)
    end
    while components.size >= depth
      components.pop
    end
    components.push(parts[-1].size)
    if !parts[-1].index(".").nil?
      maxlen = [maxlen, components.sum + components.size - 1].max
    end
  end
  maxlen
end

require 'test/unit'

class TestLongestabsolutepath < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, longestabsolutepath('dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2'))
  end

  def test_ex2
    assert_equal(9, longestabsolutepath('file1.txt\nfile2.ext\na.png'))
  end

  def test_ex3
    assert_equal(38, longestabsolutepath('my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png'))
  end

  def test_ex4
    assert_equal(14, longestabsolutepath('root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt'))
  end

  def test_ex5
    assert_equal(32, longestabsolutepath('a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt'))
  end

end
