use strict;
use warnings;
use feature "say";

sub min {
    my $min = shift;
    for (@_) {
        $min = $_ if $_ < $min;
    }
    return $min;
}

for my $triangle ([ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ],
    [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]) {
        my $sum = 0;
        $sum += $_ for map { min(@$_) } @$triangle;
        say join " ", (map { "[@$_]"} @$triangle), " -> $sum";
    }
