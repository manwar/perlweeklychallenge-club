#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ first };

my @input = (
    [ [qw[ O O X ]], [qw[ X O O ]], [qw[ X O O ]], ],
    [ [qw( O O X O)], [qw( X O O O)], [qw( X O O X)], [qw( O X O O)], ]
);

for my $input (@input) {
    say join "\n    ", '', map { join ' ', $_->@* } $input->@*;
    say '';

    my $c = lonely_x($input);
    if    ( $c == 0 ) { say "No lonely Xs were found" }
    elsif ( $c == 1 ) { say "One lonely X was found" }
    else              { say "$c lonely Xs were found" }
}

# lonely_x takes an arrayref containing a two-dimensional array
# representing an m x n matrix containing only X and O, and
# returns a count of "lonely Xs", which are Xs without an
# X in a bordering position. If none are found, it returns
# zero

sub lonely_x ( $input ) {

    my $c = 0;
    my $x = scalar $input->@*;
    my $y = scalar $input->[0]->@*;

    # X and y are the outer bounds of the matrix. 
    # i and j are the location within the matrix.
    # p is the value in the current "center".
    # ii and jj are the bordering locations to i and j
    # pp is the value in the current border location

    # if pp is X, we know that i,j is not lonely,
    # and thus we used he named next to get to the 
    # next. If, instead, we get to the end of the ii,jj
    # loops, it must be lonely and we increment our 
    # "lonely X" count.

    for my $i ( 0 .. $x ) {
    OUT: for my $j ( 0 .. $y ) {
            my $p = $input->[$i][$j];
            next unless defined $p;
            my $ok = 'X' eq $p ? 1 : 0;
            next unless $ok;

            for my $ii ( $i - 1 .. $i + 1 ) {
                next if $ii < 0;
                for my $jj ( $j - 1 .. $j + 1 ) {
                    next if $jj < 0;
                    next if $i == $ii && $j == $jj;
                    my $pp = $input->[$ii][$jj];
                    next unless defined $pp;
                    next OUT if $pp eq 'X';
                }
            }
            $c++;
        }
    }

    return $c;
}
