# for a node x/y less than 1, parent is x/(y-x)
# for a node x/y larger than 1, parent is (x-y)/x

for test in [ [5, 2], [2, 5], [3, 4], [3,5], [6, 2], [1, 2] ]
    parent = find_parent(test[1], test[2])
    gd_parent = find_parent(parent[1], parent[2])
    see "Node " + to_str(test) + " has parent " + to_str(parent) +
        " and grand-parent " + to_str(gd_parent) + nl
next

func find_parent num, denom
    if num < denom
        return [num, denom - num]
    but denom < num
        return [num - denom, denom]
    else
        return ["Error", ""]
    ok

func to_str input
    return "" + input[1] + " " + input[2]
