#! /usr/bin/env raku

unit sub MAIN (Int $N);

my $sign = $N < 0
  ?? "-"
  !! "";
  
my $new = $sign ~ $N.abs.flip;

-2147483648 <= $new <= 2147483647
  ?? say $new
  !! say "0";
