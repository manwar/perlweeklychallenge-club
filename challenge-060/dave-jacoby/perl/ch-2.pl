#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

my ( $x, $y, @l ) = grep { $_ >= 0 } map { int $_ } @ARGV;
$x //= 2;
$y //= 21;
@l = ( 0, 1, 2, 5 ) unless scalar @l;

say qq{X: $x };
say qq{Y: $y };
say q{L: } . join ', ', @l;

my @vars = get_variations( \@l, $x );
say qq{All variations of length $x:\n\t} . join ", ", @vars;

@vars = get_lt_variations( \@l, $x, $y );
say qq{All variations of length $x that are < $y:\n\t} . join ", ", @vars;
exit;

sub get_lt_variations ( $arrayref, $x, $y ) {
    return grep { $x == length $_ && $_ < $y } get_variations( $arrayref, $x );
}

sub get_variations ( $arrayref, $depth ) {
    my $output = [];
    return $arrayref->@* if $depth <= 1;
    for my $i ( 0 .. -1 + scalar $arrayref->@* ) {
        my $s = $arrayref->[$i];
        push $output->@*,
          map { int $s . $_ } get_variations( $arrayref, $depth - 1 );
    }
    return $output->@*;
}
