# For a node `x/y` with a fraction less than 1, the parent is `x/(y-x)`;
# For a node `x/y` with a fraction larger than 1, the parent is `(x-y)/x`.

def get_parent (pair)
    num = pair[0]
    denom = pair[1]
  return num < denom ? [num, denom - num] : [num - denom, denom];
end

tests = [ [5, 2], [2, 5], [3, 4], [3,5] ]
for test in tests
    parent = get_parent(test)
    gd_parent = get_parent(parent)
    print("Node #{test} - Parent: #{parent} - Grand-Parent: #{gd_parent}\n")
end
