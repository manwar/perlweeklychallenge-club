function find_parent(num, denom)
    return num < denom ? [num, denom - num] :
           num > denom ? [num - denom, denom] :
           ("Error on node $num $denom");
end

for test in [ [5, 2], [2, 5], [3, 4], [3, 5], [1, 2] ]
    parent = find_parent(test[1], test[2])
    gd_parent = find_parent(parent[1], parent[2])
    println("Node $test has parent $parent and grand-parent $gd_parent")
end
