use v6;

sub children (Int $i) { 2*$i+1, 2*$i+2 }  # not needed here
sub parent (Int $i) { ($i-1)/2; }         # not needed here

sub display ($tree) {
    my @bft_tree = bft($tree);
    my $start = (@bft_tree[*-1]).elems;
    my $sep_val = (2 * $start) - 1;
    for @bft_tree -> @line {
        my $sep = " " x $sep_val;
        say " " x $start, join $sep, @line;
        $start /= 2;
        $sep_val = ($sep_val - 1) / 2;
    }
}
sub bft ($tree) {               # Breadth First Traversal
    my ($index, $level) = (0, 0);
    my @bft_tree;
    while ($index <= $tree.end) {
        my $new_index = $index + 2 ** $level - 1;
        (@bft_tree[$level++]).append($tree[$index .. $new_index]);
        $index = $new_index + 1;
    }
    return @bft_tree;
}

my @tree = 1..7;
say "Tree before change:";
display @tree;
my $sum = [+] @tree;
my @new-tree = map { $sum - $_ }, @tree;
say "\nTree after change:";
display @new-tree;
