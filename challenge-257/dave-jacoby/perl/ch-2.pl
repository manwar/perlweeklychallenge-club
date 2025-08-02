#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ first max };

my @examples = (

    [ [ 1, 1, 0 ], [ 0, 1, 0 ], [ 0, 0, 0 ] ],
    [
        [ 0, 1, -2, 0, 1 ],
        [ 0, 0, 0,  1, 3 ],
        [ 0, 0, 0,  0, 0 ],
        [ 0, 0, 0,  0, 0 ]
    ],
    [ [ 1, 0, 0, 4 ], [ 0, 1, 0, 7 ], [ 0, 0, 1, -1 ] ],
    [
        [ 0, 1, -2, 0, 1 ],
        [ 0, 0, 0,  0, 0 ],
        [ 0, 0, 0,  1, 3 ],
        [ 0, 0, 0,  0, 0 ]
    ],
    [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 0 ] ],
    [ [ 4, 0, 0, 0 ], [ 0, 1, 0, 7 ], [ 0, 0, 1, -1 ] ]
);

for my $example (@examples) {
    my $output = reduced_row_eschelon($example);
    my $input  = format_matrix($example);
    state $i = 0;
    $i++;

    say <<~"END";
    Example $i
        Input:  \$M = $input
        Output: $output
    END
}

sub reduced_row_eschelon ($matrix) {
    my @is_nonzero_row;
    for my $i ( 0 .. -1 + scalar $matrix->@* ) {
        my @row = $matrix->[$i]->@*;

        # 1. If a row does not consist entirely of zeros, then the first
        #    nonzero number in the row is a 1. We call this the leading 1.
        my @t1 = grep { $_ != 0 } @row;
        if ( scalar @t1 ) {
            return 0 unless $t1[0] == 1;
        }

        # 2. If there are any rows that consist entirely of zeros, then
        #    they are grouped together at the bottom of the matrix.
        if ( !scalar @t1 ) {
            for my $j ( $i .. -1 + scalar $matrix->@* ) {
                my $count = scalar grep { $_ ne 0 } $matrix->[$j]->@*;
                return 0 if $count;
            }
        }

        # 3. In any two successive rows that do not consist entirely of zeros,
        #    the leading 1 in the lower row occurs farther to the right than
        #    the leading 1 in the higher row.
        $is_nonzero_row[$i] = scalar @t1 ? 1 : 0;
        if ( $i > 0 && $is_nonzero_row[$i] && $is_nonzero_row[ $i - 1 ] ) {
            my $curr =
                first { $matrix->[$i][$_] != 0 } 0 .. -1 + scalar @row;
            my $prev =
                first { $matrix->[ $i - 1 ][$_] != 0 } 0 .. -1 + scalar @row;
            return 0 unless $curr > $prev;
        }
    }

    # 4. Each column that contains a leading 1 has zeros everywhere else
    #    in that column.
    for my $i ( 0 .. -1 + scalar $matrix->[0]->@* ) {

        # 1.    get the column
        my @col = map { $matrix->[$_][$i] } 0 .. -1 + scalar $matrix->@*;

        # 2.    find the 1, determine if it's a leading 1 by checking that row
        if ( grep { $_ == 1 } @col ) {

            # for each 1
            my @ones = grep { 1 == $col[$_] } 0 .. -1 + scalar @col;
            for my $j (@ones) {
                my @row     = $matrix->[$j]->@*;
                my @sub     = @row[ 0 .. $i - 1 ];
                my $leading = ( 0 == grep { $_ != 0 } @sub ) ? 1 : 0;
                if ($leading) {
                    $col[$j] = 0;
                    my $zero_count = scalar grep { $_ ne 0 } @col;
                    return 0 if $zero_count;
                }
            }
        }
    }

    # say format_matrix($matrix);
    return 1;
}

sub format_matrix ($matrix) {
    my $maxlen = max map { length $_ } map { $_->@* } $matrix->@*;
    my $output = join "\n                  ", '[', (
        map { qq{  [$_],} } map {
            join ',',
                map { pad( $_, 1 + $maxlen ) }
                $_->@*
        } map { $matrix->[$_] } 0 .. -1 + scalar $matrix->@*
        ),
        ']';
    return $output;
}

sub pad ( $str, $len = 4 ) { return sprintf "%${len}s", $str; }
