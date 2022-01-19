#! /usr/bin/ruby

def operate(op,a,b)
  if op=="+" then
    return b+a
  elsif op=="-" then
    return b-a
  elsif op=="*" then
    return b*a
  end
end

def exval(expr)
  op=["(",")","+","-","*"]
  opp=Hash.new
  rec=["-?[0-9]+"]
  op.each_with_index do |o,i|
    opp[o]=i
    rec.push('\\' + o)
  end
  ret=Regexp.new("(" + rec.join("|") + ")")
  ren=Regexp.new("^" + rec[0] + "$")
  opstack=[]
  valstack=[]
  expr.scan(ret).each do |ta|
    token=ta[0]
    if token.match(ren) then
      valstack.push(token.to_i())
    elsif token == "(" then
      opstack.push(token)
    elsif token == ")" then
      while opstack[-1] != "(" do
        valstack.push(operate(opstack.pop(),valstack.pop(),valstack.pop()))
      end
      opstack.pop()
    elsif opp.has_key?(token) then
      while opstack.length>0 && opp[opstack[-1]] >= opp[token] do
        valstack.push(operate(opstack.pop(),valstack.pop(),valstack.pop()))
      end
      opstack.push(token)
    else
      print("bad token")
    end
  end
  while opstack.length>0 do
    valstack.push(operate(opstack.pop(),valstack.pop(),valstack.pop()))
  end
  return valstack[0]
end

require 'test/unit'

class TestExval < Test::Unit::TestCase

  def test_ex1
    assert_equal(25,exval("10 + 20 - 5"))
  end

  def test_ex2
    assert_equal(50,exval("(10 + 20 - 5) * 2"))
  end

  def test_ex3
    assert_equal(20,exval("10 + 20 - 5 * 2"))
  end

end
