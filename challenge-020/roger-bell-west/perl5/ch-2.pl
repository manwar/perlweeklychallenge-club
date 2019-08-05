#! /usr/bin/perl

use strict;
use warnings;

use Math::BigInt lib => 'GMP';
use Math::Prime::Util qw(divisors);
use List::Util qw(sum);

my $a=Math::BigInt->new(1);
while (1) {
  $a++;
  my @a=grep {$_ != $a} divisors($a);
  unless (@a) {
    next;
  }
  my $b=sum(@a);
  if ($b <= $a) {
    next;
  }
  my @b=grep {$_ != $b} divisors($b);
  unless (@b) {
    next;
  }
  my $aa=sum(@b);
  if ($aa == $a) {
    print "$a, $b\n";
  }
}
