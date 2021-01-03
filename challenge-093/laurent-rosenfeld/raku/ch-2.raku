use v6;

my @tests = [1, [2, [3,], [4,]]],
            [1, [2, [4,]], [3, [5], [6]]],
            [5, [4, [3, [7], [2]]], [8, [2], [9, [1]]]];

for @tests -> @tree {
    my $*total-sum = 0;
    say @tree;
    dfs(@tree, 0);
    say $*total-sum;
}

sub dfs (@node, $sum-so-far) {
    my $new-sum = $sum-so-far + @node[0];
    unless @node[1]:exists or @node[2]:exists {
        $*total-sum += $new-sum;
        return;
    }
    dfs(@node[1], $new-sum)
        if defined @node[1];
    dfs(@node[2], $new-sum)
        if defined @node[2];
}
