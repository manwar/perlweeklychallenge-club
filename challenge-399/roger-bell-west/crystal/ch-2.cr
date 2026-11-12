#! /usr/bin/crystal

def longestabsolutepath(fs)
  components = Array(Int32).new
  maxlen = 0
  fs.split("\n").each do |entry|
    parts = entry.split("\t")
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

require "spec"
describe "longestabsolutepath" do
  it "test_ex1" do
    longestabsolutepath("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2").should eq 0
  end
  it "test_ex2" do
    longestabsolutepath("file1.txt\nfile2.ext\na.png").should eq 9
  end
  it "test_ex3" do
    longestabsolutepath("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png").should eq 38
  end
  it "test_ex4" do
    longestabsolutepath("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt").should eq 14
  end
  it "test_ex5" do
    longestabsolutepath("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt").should eq 32
  end
end
