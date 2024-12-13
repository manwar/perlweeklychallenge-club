#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{min max};

my @examples = (
    {
        chars => [
            [ 'A', 'B', 'D', 'E' ],
            [ 'C', 'B', 'C', 'A' ],
            [ 'B', 'A', 'A', 'D' ],
            [ 'D', 'B', 'B', 'C' ],
        ],
        str => 'BDCA',
    },
    {
        chars => [
            [ 'A', 'A', 'B', 'B' ],
            [ 'C', 'C', 'B', 'A' ],
            [ 'C', 'A', 'A', 'A' ],
            [ 'B', 'B', 'B', 'B' ],
        ],
        str => 'ABAC',
    },
    {
        chars => [
            [ 'B', 'A', 'B', 'A' ],
            [ 'C', 'C', 'C', 'C' ],
            [ 'A', 'B', 'A', 'B' ],
            [ 'B', 'B', 'A', 'A' ],
        ],
        str => 'CCCAA',
    }

);

for my $example (@examples) {
    my $str    = $example->{str};
    my $chars  = display_matrix( $example->{chars}, 22 );
    my $output = word_search($example);
    say <<"END";
    Input:  \@chars = ($chars)
            \$str   = $str
    Output: $output
END
}

sub word_search($example) {
    my $str   = $example->{str};
    my $chars = $example->{chars};
    my $mx    = -1 + scalar $chars->@*;
    my $my    = -1 + scalar $chars->[0]->@*;
    my $index = 0;
    my $l     = substr $example->{str}, $index, 1;
    for my $i ( 0 .. $mx ) {
        for my $j ( 0 .. $my ) {
            my $v        = $chars->[$i][$j];
            my @position = ( $i, $j );
            if ( $l eq $v ) {
                my $output = start_word_search( $example, [ \@position ] );
                return 'true' if $output eq 'true';
            }
        }
    }
    return 'false';
}

sub start_word_search ( $example, $path ) {
    my $str   = $example->{str};
    my $chars = $example->{chars};
    my $n     = scalar $path->@*;
    my $sofar = join '',
        map { substr( $str, $_, 1 ) } 0 .. -1 + scalar $path->@*;
    my $li = -1 + scalar $chars->@*;
    my $lj = -1 + scalar $chars->[0]->@*;
    return if length $str < $n;
    if ( length $str == $n ) {
        return 'true';
    }
    my $loc = $path->[-1];
    my $pi  = $loc->[0];
    my $pj  = $loc->[1];
    my $nl  = substr $str, $n, 1;
    my $done;
    for my $p ( $path->@* ) { $done->{ $p->[0] }{ $p->[1] } = 1; }

    # I thought we could go in all 8 directions until I reread
    # and saw "orthogonal", which means strictly up,down,left,right
    my @choices = ( [ 0, 1 ], [ 0, -1 ], [ -1, 0 ], [ 1, 0 ] );

    for my $c (@choices) {
        my ( $ci, $cj ) = $c->@*;
        my $i = $ci + $pi;
        my $j = $cj + $pj;
        next if $done->{$i}{$j};    # don't go anywhere you've been
        next if $i < 0 || $i > $li; # stay in range for both
        next if $j < 0 || $j > $lj; # the x and y axis
        my $v = $chars->[$i][$j];
        next unless $nl eq $v;      # don't deal with the wrong letter
        my @p2 = $path->@*;
        push @p2, [ $i, $j ];
        my $out = start_word_search( $example, \@p2 );
        if ( $out eq 'true' ) { return 'true' }
    }
    return 'false';
}

sub display_matrix ( $matrix, $size = 5 ) {
    my $pad = ' ' x $size;
    return join ",\n$pad", map {
        join ' ', '[', ( join ', ', map { qq{'$_'} } $_->@* ), ']'
    } $matrix->@*;
}
