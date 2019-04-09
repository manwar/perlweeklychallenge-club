#!/usr/bin/env perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';

my $bi = shift // 10;
die "Invalid input base '$bi'.\n"
  unless looks_like_number($bi)
  and $bi > 1
  and $bi < 37;
my $bo = shift // 35;
die "Invalid output base '$bo'.\n"
  unless looks_like_number($bo)
  and $bo > 1
  and $bo < 37;

my $i      = 0;
my @digits = ( 0 .. 9, 'A' .. 'Z' );
my %digits = map { $_ => $i++ } @digits;

while ( readline() ) {
    chomp;
    my ( $i, $o, $n, $b ) = ( uc($_), '', 0, 1 );
    while ( length $i ) {
        $i =~ s/^(.*?)\s*(.)$/$1/;
        die "Invalid digit '$2'.\n"
          unless exists $digits{$2} and $digits{$2} < $bi;
        $n += $b * $digits{$2};
        $b *= $bi;
    }
    while ($n) {
        $o .= $digits[ $n % $bo ];
        $n = int( $n / $bo );
    }
    print( ( length $o ? reverse $o : '0' ) . "\n" );
}
