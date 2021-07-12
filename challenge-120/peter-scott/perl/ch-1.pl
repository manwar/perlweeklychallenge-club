#!/usr/local/bin/perl
use 5.016;
use warnings;

my $x = shift;
my $y = 0;
for ( 0 .. 3 )
{
  my $m = 3 << (2*$_);
  my $t = $x & $m;
  my $s = $t << 1 | $t >> 1;
  $y |= $s & $m;
}
say $y;

