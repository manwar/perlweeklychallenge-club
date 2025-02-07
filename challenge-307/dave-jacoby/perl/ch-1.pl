#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ sum0 };

my @examples = (

    [ 5, 2, 4, 3, 1 ],
    [ 1, 2, 1, 1, 3 ],
    [ 3, 1, 3, 2, 3 ],
);

for my $example (@examples) {
    my $ints   = join ', ', $example->@*;
    my @output = check_order( $example->@* );
    my $output = join ', ', @output;
    say <<"END";
    Input:  \@ints = ($ints)
    Output: ($)output
END
}

sub check_order (@ints) {
    my @sort   = sort { $a <=> $b } @ints;
    my @output = grep { $ints[$_] ne $sort[$_] } 0 .. $#ints;
    return @output;
}
