#! /usr/bin/env perl6

use Math::Matrix;

unit sub MAIN (Int $size where $size > 0);

my $im = Math::Matrix.new-identity( $size );

say $im;
