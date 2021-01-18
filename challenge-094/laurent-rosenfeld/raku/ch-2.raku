use v6;

my @tests = [1, [2, [3,], [4,]]],
            [1, [2, [4,]], [3, [5], [6]]],
            [5, [4, [3, [7], [2]]], [8, [2], [9, [1]]]];

for @tests -> @tree {
    say @tree;
    my @flat-tree = flatten-it @tree;
    say "Flat tree", @flat-tree;
    my $ll-root = list-to-linked-list @flat-tree;
    say "Linked list: ", $ll-root;
    say "Flat linked list: ", flatten-it($ll-root), "\n";
}
sub flatten-it (@node)  {
    sub dfs (@node) {
        push @*flat-list, @node[0];
        dfs(@node[1]) if defined @node[1];
        dfs(@node[2]) if defined @node[2];
    }
    my @*flat-list;
    dfs @node;
    return @*flat-list
}
sub list-to-linked-list (@list is copy) {
    my $last = pop @list;
    my $current = [$last, ];
    for @list.reverse -> $item {
        $current = [$item, $current];
    }
    return $current;
}
