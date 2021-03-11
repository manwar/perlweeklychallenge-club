#! /usr/bin/ruby

require 'csv'

def wp(ts,tn,csvfile)
  td=(tn-ts)*1000
  aoa=Array.new
  CSV.foreach(csvfile) do |row|
    aoa.push([row[0].to_i,row[1]])
  end
  tp=aoa.map{|t| t[0]}.sum
  td=td%tp
  aoa.each do |t|
    if td<t[0] then
      td=(td/1000).floor
      h=(td/3600).floor
      m=(td/60).floor % 60
      s=td % 60
      return sprintf('%02d:%02d:%02d %s',h,m,s,t[1])
    else
      td -= t[0]
    end
  end
end

require 'test/unit'

class TestWp < Test::Unit::TestCase

  def test_ex1
    assert_equal('00:10:24 Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)',wp(1606134123,1614591276,'t2.csv'))
  end

end
