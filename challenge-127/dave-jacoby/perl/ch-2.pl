#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

my @examples;

push @examples, [ [ 1, 4 ], [ 3, 5 ], [ 6, 8 ], [ 12, 13 ], [ 3, 20 ] ];
push @examples, [ [ 3, 4 ], [ 5, 7 ], [ 6, 9 ], [ 10, 12 ], [ 13, 15 ] ];
push @examples, [ [ 3, 4 ], [ 1, 5 ] ];
push @examples, [ [ 1, 4 ], [ 2, 3 ] ];
push @examples, [ [ 3, 6 ], [ 1, 5 ] ];
push @examples, [ [ 1, 3 ], [ 5, 7 ] ];

for my $e (@examples) {
    my $o = conflict_intervals($e);
    print 'INPUT:  ';
    say join " ", map { '[' . ( join ', ', $_->@* ) . ']' } $e->@*;

    print 'OUTPUT: ';
    say join " ", map { '[' . ( join ', ', $_->@* ) . ']' } $o->@*;
    say '';
}

sub conflict_intervals( $e ) {
    my @output;

OUTER: for my $i ( 0 .. -1 + scalar $e->@* ) {
        my @ii = $e->[$i]->@*;

        for my $j ( 0 .. $i - 1 ) {
            my @jj   = $e->[$j]->@*;
            my $flag = 0;

            if ( $ii[0] >= $jj[0] && $ii[0] <= $jj[1] ) {
                $flag = 1;
            }

            if ( $ii[1] >= $jj[0] && $ii[1] <= $jj[1] ) {
                $flag = 1;
            }

            if ( $jj[0] >= $ii[0] && $jj[0] <= $ii[1] ) {
                $flag = 1;
            }

            if ( $jj[1] >= $ii[0] && $jj[1] <= $ii[1] ) {
                $flag = 1;
            }

            push @output, \@ii if $flag;
            next OUTER if $flag;
        }
    }
    return wantarray ? @output : \@output;
}
