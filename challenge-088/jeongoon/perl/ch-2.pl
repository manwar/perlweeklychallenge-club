#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

# tested with:
# echo "[a b c e f][g h i j k ][l m n o p][q r s t u]" | perl ch-2.pl

use strict; use warnings;
use v5.26;

++$|;

sub readMatrixFromStdin () {
    my @matrix = ();
    while (<STDIN>) {
        push @matrix, map { s/\[//g;
                            [ split /\s+/ ] } ( grep { !/^$/ }
                                                split "\n",
                                                join "\n",
                                                split /\]/ );
    }

    @matrix
}

# translated from ch-2.go
sub getSpiralArrayFromMatrixRef ($) {
    my @mat = @{$_[0]}; # copy

    my $num_rows = scalar @mat;
    my $num_cols = scalar @{$mat[0]};

    my @spiral_array;
    for ( my $o = 0; $num_rows > 0 && $num_cols > 0; ++$o ) {
        my ($row_end, $col_end) = map { $o + $_ -1 } $num_rows, $num_cols;

        # north
        push @spiral_array, @{$mat[$o]}[$o .. $col_end];
        # east
        if ( $num_rows > 1 ) {
            push @spiral_array,
              map { $_->[$col_end] } @mat[ $o + 1 .. $row_end ];
            # south
            if ( $num_cols > 1 ) {
                push @spiral_array,
                  @{$mat[$row_end]}[ reverse $o .. ($col_end -1) ];
                # west
                if ( $num_rows > 2 ) {
                    push @spiral_array,
                      map { $_->[$o] } reverse @mat[ $o + 1 .. $row_end - 1 ];
                }
            }
        }
        # go inner matrix
        $num_rows -= 2;
        $num_cols -= 2;
    }

    @spiral_array
}


my @matrix = readMatrixFromStdin;
say STDERR "given matrix:";
say STDERR "[@$_]" for @matrix;
say STDERR "\n";

#my $c = 0;
#say "@{[$c++]}: @$_" for @matrix;

say "[",
  ( join " ",
    getSpiralArrayFromMatrixRef( \@matrix ) ),
  "]";
