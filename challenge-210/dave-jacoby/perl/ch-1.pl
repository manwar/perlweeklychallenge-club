#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max sum uniq };

my @examples = (

    [qw{ 2 3 1 }],
    [qw{ 1 1 2 2 2 3 }],
    [qw{ 1 2 3 4 5 }],

);

for my $e (@examples) {
    my @int = $e->@*;
    my $int = join ', ', @int;
    my $o   = kill_and_win(@int);
    say <<"END";
    Input:  \@int = ($int)
    Output: $o
END
}

# as described, you can delete any integer, which extends to 
# any other integers of that value, and every value within 1.
# so, deleting 2 in 1 2 2 2 1 3 3 1 would delete every 1, 2 and 3
# in that array.
# I take the absolute value of the integer in the array subtracted by
# the integer in question, and use sum() because I trust all values are
# integers.
sub kill_and_win ( @int ) {
    my @uniq = uniq sort @int;
    my $max  = -1;
    for my $i (@uniq) {
        my @deleted  = grep { abs $_ - $i <= 1 } @int;
        my $sum = sum @deleted;
        $max = $max < $sum ? $sum : $max;
    }
    return $max;
}
