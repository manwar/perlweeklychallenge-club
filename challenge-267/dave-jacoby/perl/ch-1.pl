#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc postderef say signatures state };

use List::Util qw{ any product };

my @examples = (

    [ -1, -2, -3, -4, 3, 2, 1 ],
    [ 1,  2,  0,  -2, -1 ],
    [ -1, -1, 1,  -1, 2 ],
);

for my $example (@examples) {
    my $output = product_sign(@$example);
    my $input  = join ', ', @$example;
    say <<"END";
    Input:  \@ints = ($input)
    Output: $output
END
}

sub product_sign (@ints) {
    if ( any { $_ == 0 } @ints ) {
        return 0;
    }
    if ( ( scalar grep { $_ < 0 } @ints ) % 2 == 0 ) {
        return 1;
    }
    return -1;
}
