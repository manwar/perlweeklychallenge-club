#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 288 Task 2: Contiguous Block
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );

sub flood_and_mark( $matrix, $r, $c, $visited ) {
    $visited->[$r][$c] = 1;
    my @neighbors = (
        $r > 0                  ? ( $r - 1, $c ) : (),
        $c > 0                  ? ( $r, $c - 1 ) : (),
        $c < $matrix->[$r]->$#* ? ( $r, $c + 1 ) : (),
        $r < $matrix->$#*       ? ( $r + 1, $c ) : (),
    );
    my $symbol = $matrix->[$r][$c];
    my $count = 1;      # For this field itself.
    for my ( $next_r, $next_c ) ( @neighbors ) {
        next
            if $matrix->[$next_r][$next_c] ne $symbol
                || $visited->[$next_r][$next_c];
        $count += flood_and_mark( $matrix, $next_r, $next_c, $visited );
    }
    return $count;
}

sub contiguous_block( $matrix ) {
    my @visited;
    my $max = 0;
    for my $r ( 0..$matrix->$#* ) {
        for my $c ( 0..$matrix->[$r]->$#* ) {
            if ( ! $visited[$r][$c] ) {
                my $area = flood_and_mark( $matrix, $r, $c, \@visited );
                $max = $area
                    if $area > $max;
            }
        }
    }
    return $max;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

my $sub_name = "contiguous_block";
my @tests = (
    [ 'Example 1:', [
        ["x", "x", "x", "x", "o"],
        ["x", "o", "o", "o", "o"],
        ["x", "o", "o", "o", "o"],
        ["x", "x", "x", "o", "o"],
    ], 11 ],
    [ 'Example 2:', [
        ["x", "x", "x", "x", "x"],
        ["x", "o", "o", "o", "o"],
        ["x", "x", "x", "x", "o"],
        ["x", "o", "o", "o", "o"],
    ], 11 ],
    [ 'Example 3:', [
        ["x", "x", "x", "o", "o"],
        ["o", "o", "o", "x", "x"],
        ["o", "x", "x", "o", "o"],
        ["o", "o", "o", "x", "x"],
    ], 7 ],
    [ 'Extra 1:', [
        ["x", "o", "x", "o", "x"],
        ["o", "x", "o", "x", "o"],
        ["x", "o", "x", "o", "x"],
        ["o", "x", "o", "x", "o"],
    ], 1 ],
    [ 'Extra 2: empty matrix => 0', [], 0 ],
);

# This runs the tests not only for the sub named "$sub_name",
# but also for all variants with any suffix ("$subname<suffix>").
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "\n", "Testing $sub:\n", "\n";
    for ( @tests ) {
        my ( $descr, $input, $output ) = $_->@*;
        $descr .= " " . pp( $input ) . " => $output"
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
        is $sub->( $input ), $output, $descr;
    }
}
done_testing;

__END__

is contiguous_block( [
  ["x", "x", "x", "x", "o"],
  ["x", "o", "o", "o", "o"],
  ["x", "o", "o", "o", "o"],
  ["x", "x", "x", "o", "o"],
] ), 11,
    'Example 1: contiguous_block( [
  ["x", "x", "x", "x", "o"],
  ["x", "o", "o", "o", "o"],
  ["x", "o", "o", "o", "o"],
  ["x", "x", "x", "o", "o"],
] ) == 11';
is contiguous_block( [
  ["x", "x", "x", "x", "x"],
  ["x", "o", "o", "o", "o"],
  ["x", "x", "x", "x", "o"],
  ["x", "o", "o", "o", "o"],
] ), 11,
    'Example 2: contiguous_block( [
  ["x", "x", "x", "x", "x"],
  ["x", "o", "o", "o", "o"],
  ["x", "x", "x", "x", "o"],
  ["x", "o", "o", "o", "o"],
] ) == 11';
is contiguous_block( [
  ["x", "x", "x", "o", "o"],
  ["o", "o", "o", "x", "x"],
  ["o", "x", "x", "o", "o"],
  ["o", "o", "o", "x", "x"],
] ), 7,
    'Example 3: contiguous_block( [
  ["x", "x", "x", "o", "o"],
  ["o", "o", "o", "x", "x"],
  ["o", "x", "x", "o", "o"],
  ["o", "o", "o", "x", "x"],
] ) == 7';

is contiguous_block( [
  ["x", "o", "x", "o", "x"],
  ["o", "x", "o", "x", "o"],
  ["x", "o", "x", "o", "x"],
  ["o", "x", "o", "x", "o"],
] ), 1,
    'Extra 1: contiguous_block( [
  ["x", "o", "x", "o", "x"],
  ["o", "x", "o", "x", "o"],
  ["x", "o", "x", "o", "x"],
  ["o", "x", "o", "x", "o"],
] ) == 1';

is contiguous_block( [] ), 0,
    'Extra 2: contiguous_block( [] ) == 0';

done_testing;
