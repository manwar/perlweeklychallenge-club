def swap_nibbles(n)
  return 16 * (n % 16) + (n // 16)
end

#puts swap(101)
#puts swap(18)

(0..255).each {|num|
  puts "%08b %3s %3s" % {num, num, swap_nibbles(num)}
}
