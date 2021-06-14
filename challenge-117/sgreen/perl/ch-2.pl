#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

our $first = 1;

sub _make_move {
    my ( $size, $x, $y, $this_path ) = @_;

    if ( $x == $size and $y == $size ) {
        # We have a solution
        print $first ? "Output: $this_path" : ", $this_path";
        $first = 0;
        return 1;
    }

    my $count = 0;
    if ( $y < $size ) {
        # Move diagonally left
        $count += _make_move( $size, $x, $y + 1, "${this_path}L" );

        # Move diagonally right
        $count += _make_move( $size, $x + 1, $y + 1, "${this_path}R" );
    }

    if ( $x < $y ) {
        # Move right
        $count += _make_move( $size, $x + 1, $y, "${this_path}H" );
    }

    return $count;
}

sub main {
    my $lines = shift;

    die "Lines must be a positive integer" if $lines !~ /^[1-9][0-9]*$/;

    my $count = _make_move( $lines, 0, 0, '', 0 );

    say '';
    say "A total of $count paths found";
}

main(@ARGV);
