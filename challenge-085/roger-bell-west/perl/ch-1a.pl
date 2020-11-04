#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(ts(1.2, 0.4, 0.1, 2.5),1,'example 1');
is(ts(0.2, 1.5, 0.9, 1.1),0,'example 2');
is(ts(0.5, 1.1, 0.3, 0.7),1,'example 3');

use List::Util qw(sum);

sub ts {
  my @n=grep {$_ < 2} @_;
  foreach my $a (0..$#n-2) {
    foreach my $b ($a+1..$#n-1) {
      my $s=$n[$a]+$n[$b];
      if ($s>=2) {
        next;
      }
      my $sb=2-$s;
      my $sa=1-$s;
      if (grep {$n[$_]>$sa && $n[$_]<$sb} ($b+1..$#n)) {
        return 1;
      }
    }
  }
  return 0;
}
