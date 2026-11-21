#!/usr/bin/env ruby

require 'minitest/autorun'
require 'set'

def minimum_genetic_mutation(start,finish,bank)
  return 0 if start == finish

  valid = bank.to_set

  return -1 unless valid.include?(finish)

  seen = Set[start]
  queue = [[start,0]]

  until queue.empty?
    gene,steps = queue.shift
    gene.length.times do |i|
      %w[A C G T].each do |c|
        next if gene[i] == c
        nxt = gene.dup
        nxt[i] = c
        next unless valid.include?(nxt)
        next unless seen.add?(nxt)
        return steps+1 if nxt == finish
        queue << [nxt,steps+1]
      end
    end
  end
  -1
end

class TestMinimumGeneticMutation < Minitest::Test
  def test_examples
    assert_equal(-1, minimum_genetic_mutation('AACCGGTT', 'AACCGGTA',
                                              %w[AACCGCTA AAACGGTA]), 'Example 1')
    assert_equal 2, minimum_genetic_mutation('AACCGGTT', 'AACCGGAA',
                                             %w[AACCGGTA AACCGGAA AACCGCTA AACCCTAA AACCGTAA]), 'Example 2'
    assert_equal(-1, minimum_genetic_mutation('AAAAAAAA', 'AAAAACCC',
                                              %w[CAAAAAAA CCAAAAAA AAAAAAAC]), 'Example 3')
    assert_equal 7, minimum_genetic_mutation('GAAAAAAA', 'GCCCCCCC',
                                             %w[GCAAAAAA GCCAAAAA GCCCAAAA GCCCCAAA GCCCCCAA GCCCCCCA GCCCCCCC]), 'Example 4'
    assert_equal 0, minimum_genetic_mutation('AACCGGTT', 'AACCGGTT',
                                             %w[AACCGGTA]), 'Example 5'
  end
end

