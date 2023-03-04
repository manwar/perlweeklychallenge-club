#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 min max };
use Getopt::Long;

my $verbose = 0;
GetOptions( verbose => \$verbose, );

my @examples = (

    [ 1, 2, 3, 4 ],
    [ 0, 2, 1, 3 ],
    [ 2, 4, 6, 8, 10, 12 ],
    [ 1, 2, 3, 4, 5,  6, 7, 8 ],
);

for my $e (@examples) {
    my $o     = array_pairings($e);
    my $array = join ', ', $e->@*;
    say <<"END";
    Input:  \@array = $array
    Output: $o
END
}

sub array_pairings ( $array, $pairs = [] ) {
    my @output;
    if ( !scalar $array->@* ) {
        my $sum = sum0 map { min $_->@* } $pairs->@*;
        say join ' ', '|', ( map { join 'x', $_->@* } $pairs->@* ), '', $sum
            if $verbose;
        return $sum;
    }
    for my $i ( 1 .. -1 + scalar $array->@* ) {
        my @array_copy = $array->@*;
        my @pairs_copy = $pairs->@*;
        my $y          = $array_copy[$i];
        $array_copy[$i] = undef;
        @array_copy = grep { defined } @array_copy;
        my $x = shift @array_copy;
        push @pairs_copy, [ $x, $y ];
        push @output,     array_pairings( \@array_copy, \@pairs_copy );
    }
    say '  ' . join ' ', @output if $verbose;
    return max @output;
}
