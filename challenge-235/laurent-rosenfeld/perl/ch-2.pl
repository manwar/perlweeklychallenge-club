use strict;
use warnings;
use feature 'say';

sub duplicate_zeros {
    my @result = map { $_ == 0 ? (0, 0) : $_ } @_;
    return @result[0..$#_];
}

for my $test ([<1 0 2 3 0 4 5 0>],
    [<1 2 3>], [<0 3 0 4 5>]) {
    printf "%-18s => ", "@$test";
    say join " ", duplicate_zeros @$test;
}
