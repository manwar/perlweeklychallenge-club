#!/usr/bin/ruby -w
# ch-2.rb

# https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
#
# ## Task 2 > Curious Fraction Tree
# =================================
#
# Consider the following `Curious Fraction Tree`:
#
# ```
#                __________1/1__________
#               /                       \
#         ___1/2___                   ___2/1___
#        /         \                 /         \
#     1/3           3/2           2/3           3/1
#    /   \         /   \         /   \         /   \
# 1/4     4/3   3/5     5/2   2/5     5/3   3/4     4/1
# ```
#
# You are given a fraction, member of the tree created similar to the above
# sample.
#
# Write a script to find out the parent and grandparent of the given member.
#
# **Example 1:**
#
# ```
# Input: $member = '3/5';
# Output: parent = '3/2' and grandparent = '1/2'
# ```
#
# **Example 2:**
#
# ```
# Input: $member = '4/3';
# Output: parent = '1/3' and grandparent = '1/2'
# ```

################################################################################
# PWC Solution #################################################################
################################################################################

def get_curious_parent(member)
  num, den = member.split(%r{/}, 2).map(&:to_i)
  val = num.to_f / den.to_f
  return nil unless val != 1.0
  return "#{num - den}/#{den}" unless val < 1
  return "#{num}/#{den - num}" unless val > 1
end

def get_curious_tree(member)
  parents = []
  child = member
  until child.nil?
    parents.push child
    child = get_curious_parent(child)
  end
  parents
end

def get_curious_generations(tree, generations = 2)
  return [tree[1]] unless tree.length > 2
  tree.slice(1, generations)
end

################################################################################
# Utilities ####################################################################
################################################################################

def color_str(color, str)
  colors = {
    green: "\e[32m",
    red: "\e[31m",
    reset: "\e[0m",
    yellow: "\e[33m"
  }
  colors[color] + str + colors[:reset]
end

def format_results(tree, results = '')
  tree.each_with_index do |member, idx|
    length = tree.length
    results += color_str(:yellow, 'parent') unless idx > 0
    results += color_str(:yellow, 'great-' * (idx - 1)) unless idx < 2
    results += color_str(:yellow, 'grandparent') unless idx < 1
    results += ' = ' + color_str(:green, member)
    results = length == 2 && idx.zero? ? results + ' and ' : results
    results = idx == length - 2 && length != 2 ? results + ', and ' : results
    results = length > 2 && idx < length - 2 ? results + ', ' : results
  end
  results
end

def assert_root(tree)
  last = tree[-1]
  last != '1/1' && color_str(:yellow, 'Curious fraction tree rooted at ') +
    color_str(:red, last) +
    color_str(:yellow, ' and not at ') +
    color_str(:green, '1/1')
end

################################################################################
# Main #########################################################################
################################################################################

prompt =
  'Enter a fraction (i.e.: "' +
  color_str(:green, '3/5') +
  '") or type "' +
  color_str(:yellow, 'exit') +
  '" to quit /> '

more_prompt =
  'Enter "' +
  color_str(:yellow, 'more') +
  '" to see more details, or enter a fraction (i.e.: "' +
  color_str(:green, '3/5') +
  '") to continue /> '

banner = 'A Curious Fraction Tree'

puts color_str(:yellow, banner)
puts color_str(:yellow, '=' * banner.length)

current_tree = nil
generations = nil
asserted_root = nil

print prompt

loop do
  input = gets.chomp
  input.strip!
  case input
  when %r{\A1\/1\z}
    puts color_str(:green, input) + ' is root.'
    print prompt
  when %r{\A\d+\/\d+\z}
    current_tree = get_curious_tree(input)
    generations = get_curious_generations(current_tree)
    asserted_root = assert_root(current_tree)
    puts format_results(generations)
    print more_prompt
  when /\Amore\z/i
    tree = current_tree.slice(1, current_tree.size - 1)
    puts format_results(tree)
    puts asserted_root if asserted_root
    current_tree = nil
    generations = nil
    asserted_root = nil
    print prompt
  when /exit|quit|q/i
    puts color_str(:yellow, 'Goodbye.')
    exit
  else puts "I don't understand #{color_str(:yellow, input)}"
  end
end
