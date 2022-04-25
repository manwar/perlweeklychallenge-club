#! /usr/bin/ruby

require 'test/unit'

def encrypt(kw,plaintext)
  return playfair(1,kw,plaintext)
end

def decrypt(kw,ciphertext)
  return playfair(-1,kw,ciphertext)
end

def posmod(a,b)
  m = a % b
  while m < 0 do
    m += b
  end
  return m
end

def playfair(dir,kwi0,input)
  kw = ""
  k = {}
  kwi = kwi0.downcase.gsub(/[^a-z]+/,"")
  kwi += "a".upto("z").to_a.join("")
  kwi.split("").each do |char|
    if char == "j" then
      char = "i"
    end
    if !k.has_key?(char) then
      k[char] = true
      kw += char
    end
  end
  grid = []
  gc = {}
  index = 0
  0.upto(4) do |row|
    r = []
    0.upto(4) do |column|
      r.push(kw[index])
      gc[kw[index]]=[row,column]
      index += 1
    end
    grid.push(r)
  end
  ii = input.downcase.gsub(/[^a-z]+/,"").gsub(/j/,"i")
  out = ""
  index = 0
  while index < ii.length do
    ca = ii[index]
    cb = "x"
    if index+1 < ii.length then
      cb = ii[index+1]
    end
    index += 2
    if ca == cb then
      cb = "x"
      index -= 1
    end
    (car,cac) = gc[ca]
    (cbr,cbc) = gc[cb]
    (oar,oac,obr,obc) = [car,cac,cbr,cbc]
    if car == cbr then
      oac = posmod(cac + dir, 5)
      obc = posmod(cbc + dir, 5)
    elsif cac == cbc then
      oar = posmod(car + dir, 5)
      obr = posmod(cbr + dir, 5)
    else
      oac = cbc
      obc = cac
    end
    out += grid[oar][oac] + grid[obr][obc]
  end
  return out
end

class TestPlayfair < Test::Unit::TestCase

  def test_ex1
    assert_equal("bmodzbxdnabekudmuixmmouvif",
                 encrypt("playfair example",
                         "hide the gold in the tree stump"))
  end

  def test_ex2
    assert_equal("thewexeklychallengex",
                 decrypt("perl and raku",
                         "siderwrdulfipaarkcrw"))
  end

end
