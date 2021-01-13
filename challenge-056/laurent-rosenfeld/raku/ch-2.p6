use v6;

my @tree = [5, [4, [11, [7], [2]]], [8, [13], [9, [1]]]] ;

sub dfs (@node, $target, $sum, @path) {
    my $new-sum = $sum + @node[0];
    unless @node[1]:exists or @node[2]:exists {
        say $new-sum, " -> @path[] @node[0]" if $new-sum == $target;
    }
    dfs(@node[1], $target, $new-sum, (@path, @node[0]).flat)
        if defined @node[1];
    dfs(@node[2], $target, $new-sum, (@path, @node[0]).flat)
        if defined @node[2];
}

my $target = @*ARGS.elems == 1 ?? @*ARGS[0] !! 22;
dfs(@tree, $target, 0, []);
