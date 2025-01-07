#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(threedigitseven([2, 1, 3, 0]), [102, 120, 130, 132, 210, 230, 302, 310, 312, 320], 'example 1');
is_deeply(threedigitseven([2, 2, 8, 8, 2]), [222, 228, 282, 288, 822, 828, 882], 'example 2');

use Algorithm::Permute;

sub threedigitseven($a) {
  my %s;
  foreach my $d (1 .. 3) {
    my $p = Algorithm::Permute->new($a, $d);
    while (my @px = $p->next) {
      my $c = join('', @px);
      if ($c >= 100 && $c <= 999 && $c % 2 == 0) {
        $s{$c} = 1;
      }
    }
  }
  [sort {$::a <=> $::b} keys %s];
}
