use strict;
use warnings;
use feature "say";

sub pairings {
    my @sorted = sort { $b <=> $a } @_;
    return $sorted[1] + $sorted[3];
}

for my $test ([<1 2 3 4>], [<6 5 4 3 2 1>],
              [<0 2 1 3>], [<34 12 1 11>]) {
     printf "%-15s => %d\n", "@$test", pairings @$test;
}
