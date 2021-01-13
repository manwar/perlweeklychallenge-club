#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(
  all
  any
  max
  min
);

# You are given m x n character matrix consists of O and X only.
#
# Write a script to count the total number of X surrounded by O only. Print 0 if none found.

my ($file) = @ARGV;

my $fh;
if ($file) {
    open( $fh, '<', $file );
}
else {
    $fh = *STDIN;
}

my $matrix      = parse_input($fh);
my @lonely_xses = lonely_xses($matrix);

say scalar @lonely_xses;
if ( $ENV{DEBUG} ) {
    say "Lonely X found at Row "
      . ( $_->[0] + 1 ) . ' Col '
      . ( $_->[1] + 1 ) . '.'
      for @lonely_xses;
}

exit 0;

sub lonely_xses($matrix) {
    return grep {
        all { $matrix->[ $_->[0] ][ $_->[1] ] eq 'O' } neighbors( $matrix, $_ );
    } x_positions($matrix);

}

sub x_positions($matrix) {
    return
      grep { $matrix->[ $_->[0] ][ $_->[1] ] eq 'X' }
      combinations( [ 0 .. $#{$matrix} ], [ 0 .. $#{ $matrix->[0] } ] );
}

sub neighbors ( $matrix, $pos ) {
    my ( $row, $col ) = @$pos;
    my @neighbor_rows =
      ( max( 0, $row - 1 ) .. min( $row + 1, $#{$matrix} ) );
    my @neighbor_cols =
      ( max( 0, $col - 1 ) .. min( $col + 1, $#{ $matrix->[0] } ) );

    grep { $_->[0] != $row || $_->[1] != $col }
      combinations( \@neighbor_rows, \@neighbor_cols );
}

sub combinations ( $a, $b ) {
    map {
        my $x = $_;
        map { [ $x, $_ ] } @$b;
    } @$a;
}

sub parse_input($fh) {
    chomp( my @lines = <$fh> );
    my $length;
    my @rows = map {
        my $line = $_;
        return () if $line !~ m/\S/;
        $line =~ m/^\s*\[\s*(.*?)\s*\]\s*$/;
        die "cannot parse $line" unless $1;
        my @os_and_xses = split( /\s+/, $1 );
        die "invalid input in $line" if any { $_ ne 'O' && $_ ne 'X' } @os_and_xses;
        $length //= @os_and_xses;
        die "column count not uniform" unless @os_and_xses == $length;
        \@os_and_xses;
    } @lines;

    return \@rows;
}
