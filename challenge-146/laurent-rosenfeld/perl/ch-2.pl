use strict;
use warnings;
use feature "say";

# for a node x/y less than 1, parent is x/(y-x)
# for a node x/y larger than 1, parent is (x-y)/x

sub parent {
    my ($num, $denom) = @{$_[0]};
    return ["Error"] if $num == $denom;
    return $num < $denom ? [$num, $denom - $num] : [$num - $denom, $denom];
}

for my $fraction ([5, 2], [2, 5], [3, 4], [3, 5], [2, 1], [1, 1]) {
    die "Invalid input node @$fraction" if $$fraction[0] == $$fraction[1];
    my $parent = parent $fraction;
    my $gd_parent = parent $parent;
    say "for child @$fraction, parent is @$parent and gd-parent is @$gd_parent";
}
