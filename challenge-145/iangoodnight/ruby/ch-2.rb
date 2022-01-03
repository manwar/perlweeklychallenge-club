#!/usr/bin/ruby -w
# ch-2.rb

# > https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
#
#  ## Task2 > Palindromic Tree
#  ===========================
#
#  You are given a string `$s`.
#
#  Write a script to create a `Palindromic Tree` for the given string
#
#  I found this [blog] explaining `Palindromic Tree` in detail.
#
#  **Example 1:**
#
#  ```
#  Input: $s = 'redivider'
#  Output: r redivider e edivide d divid i ivi v
#  ```
#
#  **Example 2:**
#
#  ```
#  Input: $s = 'deific'
#  Output: d e i ifi f c
#  ```
#
#  **Example 3:**
#
#  ```
#  Input: $s = 'rotors'
#  Output: r rotor o oto t s
#  ```
#
#  **Example 4:**
#
#  ```
#  Input: $s = 'challenge'
#  Output: c h a l ll e n g
#  ```
#
#  **Example 5:**
#
#  ```
#  Input: $s = 'champion'
#  Output: c h a m p i o n
#  ```
#
#  **Example 6**
#
#  ```
#  Input: $s = 'christmas'
#  Output: c h r i s t m a
#  ```
#
#  [blog]: https://medium.com/@alessiopiergiacomi/eertree-or-palindromic-tree-82453e75025b

################################################################################
# PWC Solution #################################################################
################################################################################

def palindrome?(string)
  reversed = string.reverse
  string == reversed
end

def eertree(string)
  palindromes = []
  string.chars.each_index do |cursor|
    string[cursor..string.length - 1].chars.each_index do |idx|
      chars = idx + 1
      substring = string[cursor, chars]
      next unless palindrome?(substring)
      palindromes.push substring unless palindromes.include? substring
    end
  end
  palindromes.join ' '
end

################################################################################
# Utilities ####################################################################
################################################################################

def parse_test_case(filepath)
  lines = File.read(filepath).split("\n").reject { |line| line.match(/^\s*#/) }
  input, test = lines
  input.strip!
  test.strip!
  [input, test]
end

def print_params(path, input, test)
  puts "#{path}:"
  puts "Input: $s = #{input}"
  puts "Output: #{test}"
end

def test_solution(solution, input, test)
  result = solution.call(input)
  if test == result
    puts "\e[32mPassed \u2690\e[0m\n\n"
  else
    puts "\e[31mFailed \u2715\e[0m\n\n"
  end
end

def print_and_run(target)
  input, test = parse_test_case(target)
  print_params(target, input, test)
  test_solution(method(:eertree), input, test)
end

def run_test_suite(dir)
  tests = Dir.entries(dir).select { |f| File.file? File.join(dir, f) }
  tests.sort.each { |test| print_and_run(File.join(dir, test)) }
end

################################################################################
# Main #########################################################################
################################################################################

target = ARGV[0] || '../test_cases/ch-2'
print_and_run(target) if File.file?(target)
run_test_suite(target) if File.directory?(target)
