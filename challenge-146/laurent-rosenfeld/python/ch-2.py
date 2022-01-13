# for a node x/y less than 1, parent is x/(y-x)
# for a node x/y larger than 1, parent is (x-y)/x

def find_parent(num, denom):
    return [num, denom - num] if num < denom else [num - denom, denom]

for test in ([5, 2], [2, 5], [3, 4], [3, 5]):
    parent = find_parent(test[0], test[1])
    gd_parent = find_parent(parent[0], parent[1])
    print("Node", test, "has parent", parent, "and grand-parent", gd_parent)
