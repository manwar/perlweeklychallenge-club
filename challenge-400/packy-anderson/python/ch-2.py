#!/usr/bin/env python

from collections import deque

def mutations(gene1, gene2):
  count = 0
  g1 = list(gene1)
  g2 = list(gene2)
  for i in range(0, len(g1)):
    if g1[i] != g2[i]: count += 1
  return count

def minimum_genetic_mutation(start, end, bank):
  if start == end:    return 0, deque([])
  if end not in bank: return -1, deque([])

  branches = []
  for gene in bank:
    if mutations(start, gene) != 1: continue

    count, transitions = minimum_genetic_mutation(
      gene, end, [ g for g in bank if g != gene ]
    )
    if count < 0: continue

    count += 1
    transitions.appendleft(f'  "{start}" => "{gene}"')
    branches.append({
      "count": count, "transitions": transitions
    })

  if not branches: return -1, deque([])

  best = min(branches, key=lambda e: e["count"])
  return best["count"], best["transitions"]

def solution(start_gene, end_gene, gene_bank):
  print(f'Input: $start_gene = "{start_gene}"')
  print(f'       $end_gene   = "{end_gene}"')
  bank = ", ".join([ f'"{g}"' for g in gene_bank ])
  print(f'       @gene_bank  = ({bank})')
  count, transitions = minimum_genetic_mutation(start_gene, end_gene, gene_bank)
  print(f'Output: {count}')
  if count > 0:
    print('\nTransitions:')
    print("\n".join(transitions))

print('Example 1')
solution("AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"])

print('\nExample 2')
solution("AACCGGTT", "AACCGGAA", ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"])

print('\nExample 3')
solution("AAAAAAAA", "AAAAACCC", ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"])

print('\nExample 4')
solution("GAAAAAAA", "GCCCCCCC", ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"])

print('\nExample 5')
solution("AACCGGTT", "AACCGGTT", ["AACCGGTA"])
