#! /usr/bin/ruby

def roman2int(roman)
  if roman == "" then
    return 0
  end
  [
    [ 'M', 1000 ],
    [ 'CM', 900 ],
    [ 'D', 500 ],
    [ 'CD', 400 ],
    [ 'C', 100 ],
    [ 'XC', 90 ],
    [ 'L', 50 ],
    [ 'XL', 40 ],
    [ 'X', 10 ],
    [ 'IX', 9 ],
    [ 'V', 5 ],
    [ 'IV', 4 ],
    [ 'I', 1 ],
  ].each do |s|
    if roman.index(s[0]) == 0 then
      return s[1] + roman2int(roman[s[0].length .. -1])
    end
  end
  return 0
end

def int2roman(n0)
  number = n0
  mn = ""
  [
    [ 'M', 1000 ],
    [ 'CM', 900 ],
    [ 'D', 500 ],
    [ 'CD', 400 ],
    [ 'C', 100 ],
    [ 'XC', 90 ],
    [ 'L', 50 ],
    [ 'XL', 40 ],
    [ 'X', 10 ],
    [ 'IX', 9 ],
    [ 'V', 5 ],
    [ 'IV', 4 ],
    [ 'I', 1 ],
  ].each do |s|
    while s[1] <= number do
      mn += s[0]
      number -= s[1]
    end
  end
  return mn
end

def romanmaths(ax)
  elems = ax.split(' ')
  a = roman2int(elems[0])
  b = roman2int(elems[2])
  c = -1
  if elems[1] == "+" then
    c = a + b
  elsif elems[1] == "-" then
    c = a - b
  elsif elems[1] == "*" then
    c = a * b
  elsif elems[1] == "/" then
    c, m = a.divmod(b)
    if m != 0 then
      c = -1
    end
  elsif elems[1] == "**" then
    c = a ** b
  end
  if c > 3999 || c < 0 then
    return 'non potest'
  elsif c == 0 then
    return 'nulla'
  else
    return int2roman(c)
  end
end

require 'test/unit'

class TestRoman2int < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, roman2int('I'))
  end

  def test_ex2
    assert_equal(2, roman2int('II'))
  end

  def test_ex3
    assert_equal(4, roman2int('IV'))
  end

  def test_ex4
    assert_equal(9, roman2int('IX'))
  end

  def test_ex5
    assert_equal(30, roman2int('XXX'))
  end

  def test_ex6
    assert_equal(1666, roman2int('MDCLXVI'))
  end

  def test_ex7
    assert_equal('I', int2roman(1))
  end

  def test_ex8
    assert_equal('II', int2roman(2))
  end

  def test_ex9
    assert_equal('IV', int2roman(4))
  end

  def test_ex10
    assert_equal('IX', int2roman(9))
  end

  def test_ex11
    assert_equal('XXX', int2roman(30))
  end

  def test_ex12
    assert_equal('MDCLXVI', int2roman(1666))
  end

  def test_ex13
    assert_equal('IX', romanmaths('IV + V'))
  end

  def test_ex14
    assert_equal('CMXCIX', romanmaths('M - I'))
  end

  def test_ex15
    assert_equal('V', romanmaths('X / II'))
  end

  def test_ex16
    assert_equal('LXVI', romanmaths('XI * VI'))
  end

  def test_ex17
    assert_equal('CCCXLIII', romanmaths('VII ** III'))
  end

  def test_ex18
    assert_equal('nulla', romanmaths('V - V'))
  end

  def test_ex19
    assert_equal('non potest', romanmaths('V / II'))
  end

  def test_ex20
    assert_equal('non potest', romanmaths('MMM + M'))
  end

  def test_ex21
    assert_equal('non potest', romanmaths('V - X'))
  end

end
