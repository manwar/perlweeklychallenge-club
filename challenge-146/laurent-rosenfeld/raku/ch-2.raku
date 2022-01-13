use v6;

# for a node x/y less than 1, parent is x/(y-x)
# for a node x/y larger than 1, parent is (x-y)/x

sub parent (\num, \denom) {
    return num < denom ?? (num, denom - num) !! (num - denom, denom);
}
for (5, 2), (2, 5), (3, 4), (3, 5) -> $fraction {
    my $parent = parent |$fraction[0,1];
    my $gd-parent = parent |$parent[0,1];
    say "for child $fraction, parent is $parent and gd-parent is $gd-parent";
