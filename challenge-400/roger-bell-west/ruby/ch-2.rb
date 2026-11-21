#! /usr/bin/ruby

require 'set'

def minimumgeneticmutation(from, to, bank)
  if from == to
    return 0
  end
  paths = Hash.new
  nodes = bank.clone
  nodes.push(from)
  0.upto(nodes.length - 3) do |a|
    (a + 1).upto(nodes.length - 1) do |b|
      delta = 0
      0.upto(nodes[a].length - 1) do |c|
        if nodes[a][c] != nodes[b][c]
          delta += 1
          if delta > 1
            break
          end
        end
      end
      if delta == 1
        paths[nodes[a]] ||= []
        paths[nodes[a]].push(nodes[b])
        paths[nodes[b]] ||= []
        paths[nodes[b]].push(nodes[a])
      end
    end
  end
  seen = Set.new
  queue = []
  queue.push([from, 0])
  while queue.length > 0
    gene, depth = queue.shift
    if gene == to
      return depth
    end
    if paths.include?(gene)
      sseen = seen.clone
      d = depth + 1
      paths[gene].each do |g|
        unless seen.include?(g)
          queue.push([g, d])
          sseen.add(g)
        end
      end
      seen = sseen
    end
  end
  -1
end

require 'test/unit'

class TestMinimumgeneticmutation < Test::Unit::TestCase

  def test_ex1
    assert_equal(-1, minimumgeneticmutation('AACCGGTT', 'AACCGGTA', ['AACCGCTA', 'AAACGGTA']))
  end

  def test_ex2
    assert_equal(2, minimumgeneticmutation('AACCGGTT', 'AACCGGAA', ['AACCGGTA', 'AACCGGAA', 'AACCGCTA', 'AACCCTAA', 'AACCGTAA']))
  end

  def test_ex3
    assert_equal(-1, minimumgeneticmutation('AAAAAAAA', 'AAAAACCC', ['CAAAAAAA', 'CCAAAAAA', 'AAAAAAAC']))
  end

  def test_ex4
    assert_equal(7, minimumgeneticmutation('GAAAAAAA', 'GCCCCCCC', ['GCAAAAAA', 'GCCAAAAA', 'GCCCAAAA', 'GCCCCAAA', 'GCCCCCAA', 'GCCCCCCA', 'GCCCCCCC']))
  end

  def test_ex5
    assert_equal(0, minimumgeneticmutation('AACCGGTT', 'AACCGGTT', ['AACCGGTA']))
  end

end
