use strict;
use warnings;
use feature "say";

sub h_index {
    my @ordered = sort { $b <=> $a } @_;
    for my $i (0..$#ordered) {
        return $i if $i+1 > $ordered[$i];
    }
    # If we get here, then all papers qualify
    return scalar @ordered;
}
for my $test ([<10 8 5 4 3>], [<25 8 5 3 3>], [<12 10 9 5 11>]) {
    printf "%-15s => %d\n", "@$test", h_index @$test;
}
