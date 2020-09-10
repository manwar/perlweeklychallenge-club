#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;
use List::Util qw(sum);

=pod

=head1 Test

echo "[OOX][XOO][XOO]" | perl ch-2.pl

=cut

sub readBinaryMatrixFromStdin () {
    local $/ = '';
    my $contents = <STDIN> // '';
    $contents =~ s/\]\n*/\n/g;
    my @lines = split "\n", $contents;
    map { [ map { if (/[OX]/) { y/OX/10/; $_ } # O -> 1, X -> 0
                  else { () } } split //, $_ ] } grep { $_ ne '' } @lines;
}

sub showMatrix ($) {
    my $mat = shift;
    say "@{$$mat[$_]}" for ( 0 .. $#$mat );
}

sub VAL { 0 }
sub ROW { 1 }
sub COL { 2 }
sub SUM { 3 }

# return as ( value at (r,c),
#             row,
#             column,
#             sum around (r,c) )

sub getLonelyStatusAround ($$$) {
    my ( $mat, $r, $c ) = @_;
    ( 0 <= $r && $r < @$mat && 0 <= $c && $c < @{$$mat[0]})
        or return (-1,$r,$c,-1);
    ( $mat->[$r][$c] ) == 0 or return (1,$r,$c,-1);

    my @rg = (-1, 0, 1);
    # assume non-exist cell has value of 1
    my @cellValues = map { my $y = $r+$_;
                           $y < 0 ? (1)x 3 : # note: fill the non-exist row
                               map { my $x = $c+$_;
                                     $x < 0 ? 1 : $$mat[$y][$x] // 1 } @rg } @rg;

    0, $r, $c, (sum @cellValues);
}

package main;

say "Input: (Ctrl-D or Ctrl-Z to finish input)";
say "ex) [OOX][XOO][XOO]";
my @matrix = readBinaryMatrixFromStdin;
if ( @matrix < 1 ) {
    say 'Usage: echo "[OOX][XOO][XOO]" | perl ch-2.pl';
    warn "Using default matrix ...";

    @matrix = ([1,1,0,1],
               [0,1,1,1],
               [0,1,1,0],
               [1,0,1,1]);
}

say "Showing matrix again (O -> 1; X -> 0):";
showMatrix \@matrix;

my $count = 0;
for my $r ( 0 .. $#matrix ) {
    for my $c ( 0 .. $#{$matrix[0]} ) {
        my @stat = getLonelyStatusAround( \@matrix, $r, $c );

        if ( $stat[VAL] == 0 and $stat[SUM] == 8 ) {
            ++$count;
            say "$count: Lonely X found at Row ".($r+1)." Col ".($c+1);
        }
    }
}

say "Total $count Lonely X(s) found";
