#!ruby.exe

require 'prime'

# AUTHOR: Robert DiCicco
# DATE: 2022-05-10
# Challenge #164 Prime Palindrome ( Ruby )

(1..1000).each do |n|
  n_rev = n.to_s.reverse.to_i
  if Prime.prime?(n) && (n == n_rev)
    print("#{n} ")
  end
end

print("\n")
