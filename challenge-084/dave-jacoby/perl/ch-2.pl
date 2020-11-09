#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ max};
use JSON;
my $json = JSON->new->canonical;

my @matrices;

push @matrices,
    [ [ 0, 1, 0, 1 ], [ 0, 0, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 1 ], ];

push @matrices,
    [ [ 1, 1, 0, 1 ], [ 1, 1, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], ];

push @matrices,
    [
    [ 1, 1, 0, 1 ],
    [ 1, 1, 0, 0 ],
    [ 0, 1, 1, 1 ],
    [ 1, 0, 1, 1 ],
    [ 1, 1, 1, 1 ],
    ];

push @matrices,
    [ [ 0, 0, 0, 0 ], [ 0, 1, 1, 1 ], [ 0, 1, 1, 1 ], [ 0, 1, 1, 1 ], ];
push @matrices,
    [ [ 0, 0, 0, 0 ], [ 0, 1, 1, 1 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], ];

for my $matrix (@matrices) {
    find_square($matrix);
}

sub find_square( $matrix ) {
    my $count = 0;
    my $max = max( scalar $matrix->@* ), map { scalar $_->@* } $matrix->@*;

    for my $i ( map { $_ - 1 } 1 .. scalar $matrix->@* ) {
        for my $j ( map { $_ - 1 } 1 .. scalar $matrix->[$i]->@* ) {
            my $k = $matrix->[$i][$j];
            if ( $k == 1 ) {
                for my $m ( 1 .. $max ) {
                    my $I = $i + $m;
                    my $J = $j + $m;
                    last unless defined $matrix->[$i][$J];
                    last unless defined $matrix->[$I][$j];
                    last unless defined $matrix->[$I][$J];
                    next unless $matrix->[$i][$J] == 1;
                    next unless $matrix->[$I][$j] == 1;
                    next unless $matrix->[$I][$J] == 1;
                    $count++;
                    # say join ' ', $count, '', $i, $j, $I, $J;
                }
            }
        }
    }

    display_matrix($matrix);
    say $count;
    say '-' x 10;
}

sub display_matrix( $matrix) {
    for my $i ( map { $_ - 1 } 1 .. scalar $matrix->@* ) {
        for my $j ( map { $_ - 1 } 1 .. scalar $matrix->[$i]->@* ) {
            my $k = $matrix->[$i][$j];
            print ' ', $k;
        }
        say '';
    }
    say '';
}
