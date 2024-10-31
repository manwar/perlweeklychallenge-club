#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use Algorithm::Permute;
use Math::Trig;
my @examples = (

    [ [ 1, 1 ], [ 2, 3 ], [ 3, 2 ] ],
    [ [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] ],
    [ [ 1, 1 ], [ 1, 2 ], [ 2, 3 ] ],
    [ [ 1, 1 ], [ 1, 2 ], [ 1, 3 ] ],
    [ [ 1, 1 ], [ 2, 1 ], [ 3, 1 ] ],
    [ [ 0, 0 ], [ 2, 3 ], [ 4, 5 ] ],
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
    my $p = Algorithm::Permute->new( \@points );
    while ( my @d = $p->next ) {
        my $angle1 = get_angle( $d[0]->@*, $d[1]->@* );
        my $angle2 = get_angle( $d[0]->@*, $d[2]->@* );
        return 'false' if $angle1 == $angle2;
    }
    return 'true';
}

sub get_angle ( $x1, $y1, $x2, $y2 ) {
    return ( 180 / pi ) * atan2( $y2 - $y1, $x2 - $x1 );
}
