#! /usr/bin/ruby

def rn(d)
  out=Array.new
  mxm=10**(d-2)-1
  [2,4,6,8].each do |a|
    [0,2,3,5,7,8].each do |q|
      if a==2 && q!=2 then
        next
      end
      if a==4 && q!=0 then
        next
      end
      if a==6 && q!=0 && q!=5 then
        next
      end
      if a==8 && q!=2 && q!=3 && q!=7 && q!=8 then
        next
      end
      if d==2 then
        t="#{a}#{q}"
        if is_rare(t) then
          out.push(Integer(t))
        end
      else
        0.upto(mxm) do |md|
          mds=sprintf('%0' + "#{d-2}" + 'd',md)
          b=Integer(mds[0])
          p=Integer(mds[-1])
          if a==2 && b!=p then
            next
          end
          if a==4 && ((b-p).abs)%2 != 0 then
            next
          end
          if a==6 && ((b-p).abs)%2 != 1 then
            next
          end
          if a==8 then
            if q==2 && b+p != 9 then
              next
            end
            if q==3 && b-p != 7 && p-b != 3 then
              next
            end
            if q==7 && b+p != 1 && b+p != 11 then
              next
            end
            if q==8 && b!=p then
              next
            end
            end
            t="#{a}#{mds}#{q}"
            if is_rare(t) then
              out.push(Integer(t))
          end
        end
      end
    end
  end
  return out
end

def is_rare(t)
  tn=Integer(t)
  ds=t.reverse()
  ds.gsub!(/^0+/,"")
  d=Integer(ds)
  if d >= tn then
    return nil
  end
  [tn+d,tn-d].each do |c|
    if c =~ /[2378]$/ then
      return nil
    end
    s=Integer.sqrt(c)
    if s*s != c then
      return nil
    end
  end
  return 1
end

require 'test/unit'

class TestRn < Test::Unit::TestCase

  def test_ex1
    assert_equal([65],rn(2))
  end

  def test_ex2
    assert_equal([621770],rn(6))
  end

  def test_ex3
    assert_equal([281089082],rn(9))
  end

end
