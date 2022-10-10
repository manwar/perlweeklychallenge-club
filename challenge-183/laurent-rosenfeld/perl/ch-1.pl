use strict;
use warnings;
use feature qw/say/;

for my $test ( [[1,2], [3,4], [5,6], [1,2]],
               [[9,1], [3,7], [2,5], [2,5]] ) {
    my %unique = map { $_ => 1 } map { "[@$_]"} @$test;
    say join ", ",  keys %unique;
}
