#! /usr/bin/crystal

def common_substring(a0)
  a = a0.sort_by { |x| x.size }
  results = Array(String).new
  (a[0].size - 1).downto(1) do |l|
    0.upto(a[0].size - l) do |offset|
      m = true
      sample = a[0][offset..offset + l - 1]
      iter = a.each
      iter.next
      while !(ax = iter.next).is_a?(Iterator::Stop)
        if ax.index(sample).nil?
          m = false
          break
        end
      end
      if m
        results.push(sample)
      end
    end
    # for _longest_ common substring...
    # if results.size > 0
    #  break
    # end
  end
  results
end

def is_avc(a)
  valid = true
  laststate = false
  a.chars.each_with_index do |c, i|
    thisstate = false
    case c
    when 'a', 'e', 'i', 'o', 'u'
      thisstate = true
    end
    if i > 0 && thisstate == laststate
      valid = false
      break
    end
    laststate = thisstate
  end
  valid
end

def alternatingvowelsconsonants(a)
  c2 = common_substring(a).select{|x| is_avc(x)}
  if c2.size > 0
    l = c2[0].size
    c2.select{|x| x.size == l}
  else
    [] of String
  end
end

require "spec"
describe "alternatingvowelsconsonants" do
  it "test_ex1" do
    alternatingvowelsconsonants(["relocate", "delocate", "allocate"]).should eq ["locate"]
  end
  it "test_ex2" do
    alternatingvowelsconsonants(["apple", "banana", "cherry"]).should eq [] of String
  end
  it "test_ex3" do
    alternatingvowelsconsonants(["navigate", "cavity", "gravity"]).should eq ["avi"]
  end
  it "test_ex4" do
    alternatingvowelsconsonants(["pedalgia", "pedalboard", "pedantic"]).should eq ["peda"]
  end
  it "test_ex5" do
    alternatingvowelsconsonants(["schoolmaster", "schoolhouse", "schooling"]).should eq ["ho", "ol"]
  end
end
