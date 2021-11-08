#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Algorithm::Permute;

my @input;
push @input, [ 1, 0, 2, 6 ];
push @input, [ 1, 4, 2, 8 ];
push @input, [ 4, 1, 7, 6 ];

for my $i (@input) {
    my @arr  = $i->@*;
    my $join = join ', ', @arr;
    my $len  = largest_even_number( @arr );
    say <<"END";
    INPUT:  ($join)
    OUTPUT: $len
END
}

sub largest_even_number( @digits ) {
    my $max = -1;
    my $p = Algorithm::Permute->new( [@digits] );
    while ( my @res = $p->next ) {
        my $i = join '', @res;
        $i += 0;
        next unless $i % 2 == 0;
        $max = $i if $i > $max;
    }
    return $max;
}
