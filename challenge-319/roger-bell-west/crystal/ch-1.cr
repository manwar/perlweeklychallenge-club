#! /usr/bin/crystal

def wordcount(a)
  ct = 0
  a.each do |w|
    ct += case w[0]
          when  'a', 'e', 'i', 'o', 'u'
            1
          else
            case w[-1]
            when  'a', 'e', 'i', 'o', 'u'
              1
            else
              0
            end
          end
  end
  ct
end

require "spec"
describe "wordcount" do
  it "test_ex1" do
    wordcount(["unicode", "xml", "raku", "perl"]).should eq 2
  end
  it "test_ex2" do
    wordcount(["the", "weekly", "challenge"]).should eq 2
  end
  it "test_ex3" do
    wordcount(["perl", "python", "postgres"]).should eq 0
  end
end
