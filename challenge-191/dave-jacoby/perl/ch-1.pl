#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @input =
    ( [ 1, 2, 3, 4 ], [ 1, 2, 0, 5 ], [ 2, 6, 3, 1 ], [ 4, 5, 2, 3 ] );

for my $i (@input) {
    my $input  = join ', ', $i->@*;
    my $output = twice_largest($i);
    say <<"END";
        Input:  \$s = ($input)
        Output: $output
END
}

sub twice_largest ( $input ) {
    my @input = $input->@*;
    for my $n ( @input ) {
        my $c = 0;
        my @array = grep { $_ != $n } @input;
        for my $o (@array) {
            next if $o == $n;
            $c++ if $n >= 2 * $o;
        }
        return 1 if $c == 3;
    }
    return -1;
}
