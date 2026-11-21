#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use List::Util qw(max);
use List::MoreUtils qw(slideatatime);

sub hasrepeateddigits($a) {
  my %cs;
  foreach my $c (split '', $a) {
        if (exists $cs{$c}) {
            return 1;
        }
        $cs{$c} = 1;
    }
    0;
}

sub largestinterval($a) {
  my @v = grep {!hasrepeateddigits($_)} (1 .. $a);
  my $it = slideatatime(1, 2, @v);
  my $d = 0;
  my @va;
  while (@va = $it->()) {
    if (scalar @va == 2) {
      $d = max($d, $va[1] - $va[0]);
    }
  }
  $d;
}

use Test::More tests => 5;

is(largestinterval(20), 2, 'example 1');
is(largestinterval(110), 4, 'example 2');
is(largestinterval(500), 11, 'example 3');
is(largestinterval(2026), 105, 'example 4');
is(largestinterval(10000), 105, 'example 5');
