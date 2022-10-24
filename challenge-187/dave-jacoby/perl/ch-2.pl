#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;

my @input = ( [ 1, 2, 3, 2 ], [ 1, 3, 2 ], [ 1, 1, 2, 3 ], [ 2, 4, 3 ] );

for my $input (@input) {
    my @output = magic_triplets( $input->@* );
    my $input  = join ', ', $input->@*;
    my $output = join ', ', @output;
    say <<"END";
    Input:  \@n = ($input)
    Output: ($output)
END
}

sub magic_triplets( @array ) {
    my $p   = Algorithm::Permute->new( \@array, 3 );
    my $max = -1;
    my @output;
    while ( my @arr = $p->next ) {
        my ( $a, $b, $c ) = @arr;
        next unless $a + $b > $c;   # rule 1
        next unless $b + $c > $a;   # rule 2
        next unless $a + $c > $b;   # rule 3
        my $sum = $a + $b + $c;     # rule 4 starts here
        if ( $sum >= $max ) {
            @output = @arr;
            $max    = $sum;
        }
        my $arr = join ' ', @arr;
    }
    return @output;
}
