#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use Algorithm::Permute;
my @examples = (

    [ [ 1, 1 ], [ 2, 3 ], [ 3, 2 ] ],
    [ [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] ],
    [ [ 1, 1 ], [ 1, 2 ], [ 2, 3 ] ],
    [ [ 1, 1 ], [ 1, 2 ], [ 1, 3 ] ],
    [ [ 1, 1 ], [ 1, 1 ], [ 1, 3 ] ],
);

for my $example (@examples) {
    my $input = join ', ', map { qq{[$_]} }
        map { join ', ', $_->@* } $example->@*;
    my $output = boomerang( $example->@* );
    say <<"END";
    Input:  \@points = ( $input )
    Output: $output
END
}

sub boomerang (@points) {

    # all distinct
    my %hash;
    map { $hash{$_}++ }
        map { join ',', $_->@* } @points;
    my @values =
        map  { $hash{$_} }
        sort { $hash{$b} <=> $hash{$a} }
        keys %hash;
    return 'false' if $values[0] > 1;

    # not in a straight line
    my $p = Algorithm::Permute->new(\@points );    while ( my @d = $p->next ) {        my $x = $d[1][0] - $d[0][0];        my $y = $d[1][1] - $d[0][1];        if (( $d[1][0] + $x == $d[2][0] ) &&             ( $d[1][1] + $y == $d[2][1] )) {                 return 'false'                 }    }    return 'true';}
