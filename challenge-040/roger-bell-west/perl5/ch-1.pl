#! /usr/bin/perl

use strict;
use warnings;

my @a=(
    [qw(I L O V E Y O U)],
    [qw(2 4 0 3 2 0 1 9)],
    [qw(! ? £ $ % ^ & *)],
      );

my $ix=0;
my $r=1;
while ($r) {
  $r=0;
  my @out;
  foreach my $iy (0..$#a) {
    if (exists $a[$iy][$ix]) {
      push @out,$a[$iy][$ix];
      $r=1;
    } else {
      push @out,' ';
    }
  }
  if ($r) {
    print join(' ',@out),"\n";
  }
  $ix++;
}
