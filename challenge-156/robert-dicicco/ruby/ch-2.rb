#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE:  14-MAR-2022
# Challenge 156 Weird Numbers ( Ruby )

def divisors(n)
  divisors = (1...n).select{|numbers| n%numbers == 0}
  divisors.length == 0 ? "#{n} is prime" : divisors
end

num = ARGV[0].to_i

puts "Input: #{num}"
tmparr = divisors(num)

puts "Divisors: #{tmparr}"

sum = 0

(2..(tmparr.length - 1)).each { |i|
  arr = tmparr.permutation(i).to_a
  arr.each { |n|
      n.each { |s|
      sum += s
    }

    if sum == num
      puts "Subset: #{n} sum = #{sum}"
      puts "Output: 0"
      exit
    end

    sum = 0
  }
}

puts "No subset sums to #{num}"
puts "Output: 1"
