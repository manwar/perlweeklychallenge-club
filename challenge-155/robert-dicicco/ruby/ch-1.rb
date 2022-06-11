#!ruby.exe

require 'prime'

# Author: Robert DiCicco
# Date: 9-MAR-2022
# Challenge #155 Fortunate Numbers ( Ruby )

def primorial_number(n)
  pgen = Prime.each
  (1..n).inject(1){|p,_| p*pgen.next}
end

class Integer
  def fact
    (1..self).reduce(:*) || 1
  end
end

howmany = 8;
outarr = []

(1..howmany+1).each { |e|
  p = primorial_number(e)
  m = 1
  i = 0

  until Prime.prime?(i) do
    m = m + 1
    i = p + m
  end

  outarr.push(m)
}

p outarr.sort.uniq
