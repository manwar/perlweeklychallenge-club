#! /usr/bin/ruby

require 'set'

class Eernode
  attr_accessor :edges, :link, :len, :id
  def initialize
    @edges=Hash.new
    @len=0
    @id=rand
  end
end

class Eertree
  attr_accessor :nodes,:rto,:rte,:S,:maxSufT
  def initialize
    @nodes=[]
    @rto=Eernode.new
    @rte=Eernode.new
    @rte.link=@rto
    @rte.id="rte"
    @rto.link=rto
    @rto.len=-1
    @rto.id="rto"
    @S=["0"]
    @maxSufT=@rte
  end

  def get_max_suffix_pal(startnode,a)
    u=startnode
    i=@S.length
    k=u.len
    while u.id != "rto" && @S[i-k-1] != a do
      if u.id == u.link.id then
        break
      end
      u=u.link
      k=u.len
    end
    return u
  end

  def add(a)
    q=get_max_suffix_pal(@maxSufT,a)
    newnode=!q.edges.has_key?(a)
    if newnode then
      p=Eernode.new
      @nodes.push(p)
      p.len=q.len+2
      if p.len==1 then
        p.link=@rte
      else
        p.link=get_max_suffix_pal(q.link,a).edges[a]
      end
      q.edges[a]=p
      @maxSufT=q.edges[a]
      @S.push(a)
    end
    return newnode
  end

  def add_str(st)
    st.each_char do |a|
      add(a)
    end
  end

  def get_sub_palindromes(nd,nodestohere,charstohere)
    result=[]
    nd.edges.keys.each do |lnkName|
      nd2=nd.edges[lnkName]
      result.concat(get_sub_palindromes(nd2,nodestohere + [nd2],charstohere + [lnkName]))
    end
    if nd.id != "rto" && nd.id != "rte" then
      temp=charstohere.join("")
      revtemp=temp.reverse
      if nodestohere[0].id == "rte" then
        assembled = revtemp + temp
      else
        assembled = revtemp + temp[1..-1]
      end
      result.push(assembled)
    end
    return result
  end

end

def eertree(st)
  eertree=Eertree.new
  eertree.add_str(st)
  result=eertree.get_sub_palindromes(eertree.rto,
                                     [eertree.rto],
                                     [])
  result.concat(eertree.get_sub_palindromes(eertree.rte,
                                            [eertree.rte],
                                            []))
  q=Set.new(result)
  res=[]
  0.upto(st.length()-1) do |i|
    i.upto(st.length()-1) do |j|
      k=st[i..j]
      if q.include?(k) then
        q.delete(k)
        res.push(k)
      end
    end
  end
  return res
end

require 'test/unit'

class TestEertree < Test::Unit::TestCase

  def test_ex1
    assert_equal(["r","redivider","e","edivide","d","divid","i","ivi","v"],eertree("redivider"))
  end

  def test_ex2
    assert_equal(["d","e","i","ifi","f","c"],eertree("deific"))
  end

  def test_ex3
    assert_equal(["r","rotor","o","oto","t","s"],eertree("rotors"))
  end

  def test_ex4
    assert_equal(["c","h","a","l","ll","e","n","g"],eertree("challenge"))
  end

  def test_ex5
    assert_equal(["c","h","a","m","p","i","o","n"],eertree("champion"))
  end

  def test_ex6
    assert_equal(["c","h","r","i","s","t","m","a"],eertree("christmas"))
  end

end
