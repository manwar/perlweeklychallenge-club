#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental::postderef experimental::signatures };

use List::Util qw{uniq min max};

use JSON;
my $json = JSON->new->space_after(1);

my @examples;

# gaps over 7
push @examples, [ [ 2, 6 ], [ [ 1, 4 ], [ 8, 10 ] ] ];

# COULD glom 1-2 to 3-10 but doesn't
push @examples, [ [ 5, 10 ], [ [ 1, 2 ], [ 3, 7 ], [ 9, 12 ] ] ];

# appends the 10,11 array
push @examples, [ [ 10, 11 ], [ [ 1, 5 ], [ 7, 9 ] ] ];

# gaps over 6 array
push @examples, [ [ 8, 11 ], [ [ 1, 5 ], [ 7, 9 ] ] ];
push @examples, [ [ 7, 9 ], [ [ 1, 5 ], [ 8, 11 ] ] ];

for my $example (@examples) {
    say '=' x 10;
    print qq{N:\t};
    say $json->encode( $example->[0] );
    print qq{S:\t};
    say $json->encode( $example->[1] );
    my $out = insert_interval( $example->@* );
    print qq{Out:\t};
    say $json->encode($out);
    say '-' x 10;
}

sub insert_interval ( $n, $s ) {
    my @output;
    my @todo;

    for my $i ( 0 .. scalar $s->@* ) {
        next unless $s->[$i];
        my $e = $s->[$i];
        if ( $n->[0] > $e->[0] && $n->[0] < $e->[1] ) {
            push @todo, $i;
        }
        elsif ( $n->[1] > $e->[0] && $n->[1] < $e->[1] ) {
            push @todo, $i;
        }

    }

    # there is no overlap, so append
    if ( !scalar @todo ) {
        @output = sort { $a->[0] <=> $b->[0] } $n, $s->@*;
    }

    # overlaps one range, so expand that range
    elsif ( scalar @todo == 1 ) {
        my $i   = $todo[0];
        my $min = min $n->[0], $s->[$i][0];
        my $max = max $n->[1], $s->[$i][1];
        $s->[$i][0] = $min;
        $s->[$i][1] = $max;
        @output     = $s->@*;
    }

    # overlaps two ranges, so expand that range
    else {
        my ( $i, $j ) = @todo;
        my $min = min $n->[0], $s->[$i][0], $s->[$j][0];
        my $max = max $n->[1], $s->[$i][1], $s->[$j][1];
        $s->[$i][0] = $min;
        $s->[$i][1] = $max;
        delete $s->[$j];
        @output = $s->@*;
    }
    return wantarray ? @output : \@output;
}
