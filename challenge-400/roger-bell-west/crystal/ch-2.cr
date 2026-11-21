#! /usr/bin/crystal

def minimumgeneticmutation(from, to, bank)
  if from == to
    return 0
  end
  paths = Hash(String, Array(String)).new
  nodes = bank.clone
  nodes.push(from)
  0.upto(nodes.size - 3) do |a|
    (a + 1).upto(nodes.size - 1) do |b|
      delta = 0
      0.upto(nodes[a].size - 1) do |c|
        if nodes[a][c] != nodes[b][c]
          delta += 1
          if delta > 1
            break
          end
        end
      end
      if delta == 1
        paths[nodes[a]] ||= Array(String).new
        paths[nodes[a]].push(nodes[b])
        paths[nodes[b]] ||= Array(String).new
        paths[nodes[b]].push(nodes[a])
      end
    end
  end
  seen = Set(String).new
  queue = Array(Tuple(String, Int32)).new
  queue.push({from, 0})
  while queue.size > 0
    gene, depth = queue.shift
    if gene == to
      return depth
    end
    if paths.has_key?(gene)
      sseen = seen.clone
      d = depth + 1
      paths[gene].each do |g|
        unless seen.includes?(g)
          queue.push({g, d})
          sseen.add(g)
        end
      end
      seen = sseen
    end
  end
  -1
end

require "spec"
describe "minimumgeneticmutation" do
  it "test_ex1" do
    minimumgeneticmutation("AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"]).should eq -1
  end
  it "test_ex2" do
    minimumgeneticmutation("AACCGGTT", "AACCGGAA", ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]).should eq 2
  end
  it "test_ex3" do
    minimumgeneticmutation("AAAAAAAA", "AAAAACCC", ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]).should eq -1
  end
  it "test_ex4" do
    minimumgeneticmutation("GAAAAAAA", "GCCCCCCC", ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"]).should eq 7
  end
  it "test_ex5" do
    minimumgeneticmutation("AACCGGTT", "AACCGGTT", ["AACCGGTA"]).should eq 0
  end
end
