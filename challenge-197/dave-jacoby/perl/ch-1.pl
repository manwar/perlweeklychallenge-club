#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = ( [ 1, 0, 3, 0, 0, 5 ], [ 1, 6, 4 ], [ 0, 1, 0, 2, 0 ], );

for my $e (@examples) {
    my @list = $e->@*;
    my @out  = move_zero(@list);
    my $list = join ', ', @list;
    my $out  = join ', ', @out;
    say <<"END";
    Input:  \@list = ($list)
    Output: ($out)
END
}

sub move_zero( @list ) {
    my @digit;
    my @zero;
    for my $i (@list) {
        if   ( $i > 0 ) { push @digit, $i }
        else            { push @zero,  0 }
    }
    return( @digit, @zero);
}
