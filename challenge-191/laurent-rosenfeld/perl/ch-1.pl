use strict;
use warnings;
use feature qw/say/;

sub is_twice_as_large {
    my @sorted = sort { $b <=> $a } @_;
    return $sorted[0] >= 2 * $sorted[1];
}
for my $test ( [<1 2 3 4>], [<1 2 0 5>],
               [<2 6 3 1>], [<4 5 2 3>] ) {
    say "@$test -> ", is_twice_as_large(@$test) ? 1 : -1;
}
