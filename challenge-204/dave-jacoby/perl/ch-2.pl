#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use JSON;
my $json = JSON->new->space_after;

my @examples = (

    { r => 1, c => 4, matrix => [ [ 1, 2 ], [ 3, 4 ] ] },
    { r => 3, c => 2, matrix => [ [ 1, 2, 3 ], [ 4, 5, 6 ] ] },
    { r => 3, c => 2, matrix => [ [ 1, 2 ] ] },
);

for my $e (@examples) {
    my ( $r, $c, $matrix ) = map { $e->{$_} } qw{r c matrix};
    my $mj = $json->encode( $matrix );
    my $o = reshape_matrix( $r, $c, $matrix );
    my $j = $json->encode($o);
    say <<"END";
    Input:  \$matrix = $mj
            \$r = $r
            \$c = $c
    Output: $j
END
}

sub reshape_matrix ( $rows, $columns, $matrix ) {
    my $output;
    my @array = map { $_->@* } $matrix->@*; # flatten matrix to array
    my $x     = scalar @array;
    my $y     = $rows * $columns;
    return 0 if $x != $y;
    for my $i ( map { $_ - 1 } 1 .. $rows ) {
        for my $j ( map { $_ - 1 } 1 .. $columns ) {
            my $k = shift @array;
            $output->[$i][$j] = $k;
        }
    }
    return $output;
}
