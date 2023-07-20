#!/usr/bin/env ruby

def solve(ints)
  raise "error: can't pass an empty arg" if ints.nil?

  ints = ints.select { |n| n > 0 }.sort
  n = 0
  while ints.any?
    i = ints.shift
    ints = ints.map { |n| n - i }.select { |n| n > 0 }
    n += 1
  end
  n
end
