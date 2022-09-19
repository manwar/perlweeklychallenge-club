def stringify(input):
  return " ".join(map(str, input))

def permute(input):
  temp = input.copy() # avoid modifying input perm with the sort
  temp.sort()
  return list(itertools.permutations(temp))

def permutation2rank(perms, input):
  perms_str = map(stringify, perms)
  input_str = stringify(input)
  for index, value in enumerate(perms_str):
    if value == input_str:
      return index

def rank2permutation(permutation, rank):
  return permutation[rank]

perm = [3, 1, 2]
perms = permute(perm)
print("Permutations: ", str(perms))
rank = permutation2rank(perms, perm)
print("Permutation ", perm, " -> rank ", rank)
for i in range(0, len(perms)):
  print("Rank: ", i, " -> permutation ", rank2permutation(perms, i))
