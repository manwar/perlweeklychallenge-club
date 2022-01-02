#!/usr/bin/ruby -w
## ch-1.rb

# > https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
#
# ## Task 1 > Dot Product
# =======================
#
# You are given 2 arrays of the same size, `@a` and `@b`.
#
# Write a script to implement `Dot Product`.
#
# **Example:**
# ```
# @a = (1, 2, 3);
# @b = (4, 5, 6);
#
# $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32
# ```

################################################################################
# PWC Solution #################################################################
################################################################################

def dot_product(arr1, arr2)
  sum = 0
  arr1.each_with_index do |multiplicand, idx|
    sum += multiplicand.to_f * arr2[idx].to_f
  end
  (sum % 1).zero? ? sum.to_i : sum
end

################################################################################
# Utilities ####################################################################
################################################################################

def parse_test_case(file_path)
  lines = File.read(file_path).split("\n").reject { |line| line.match(/^\s*#/) }
  arr1, arr2, test = lines
  a = arr1.split(/\s*,\s*/)
  b = arr2.split(/\s*,\s*/)
  [a, b, test]
end

def test_solution(callback, *args, test)
  result = callback.call(*args)
  if test.to_f == result.to_f
    puts "\e[32mPassed \u2690\e[0m"
  else
    puts "\e[31mFailed \u2715\e[0m"
  end
end

def print_params(target, a, b, test)
  puts "#{target}:"
  puts "@a = #{a.join(', ')}"
  puts "@b = #{b.join(', ')}"
  puts "Dot Product: #{test}"
end

def print_and_run(target)
  a, b, test = parse_test_case(target)
  print_params(target, a, b, test)
  test_solution(method(:dot_product), a, b, test)
  puts "\n"
end

def run_test_suite(dir)
  tests = Dir.entries(dir).select { |f| File.file? File.join(dir, f) }
  tests.sort.each do |test|
    print_and_run(File.join(dir, test))
  end
end

################################################################################
# Main #########################################################################
################################################################################

target = ARGV[0] || '../test_cases/ch-1'
print_and_run(target) if File.file?(target)
run_test_suite(target) if File.directory?(target)
