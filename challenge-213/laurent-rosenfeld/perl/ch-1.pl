use strict;
use warnings;
use feature 'say';

sub fun_sort {
    return (sort { $a <=> $b } grep { $_ % 2 == 0 } @_),
           (sort { $a <=> $b } grep { $_ % 2 != 0 } @_);
}

for my $test ([<1 2 3 4 5 6>], [(1, 2)], [(1)],
    [1..15], [reverse (1..15)]) {
    say join " ", fun_sort @$test;
}
