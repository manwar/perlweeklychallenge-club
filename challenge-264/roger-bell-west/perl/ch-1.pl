#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(greatestenglishletter('PeRlwEeKLy'), 'L', 'example 1');
is(greatestenglishletter('ChaLlenge'), 'L', 'example 2');
is(greatestenglishletter('The'), '', 'example 3');

sub greatestenglishletter($a) {
  my %m;
  foreach my $c (split '', $a) {
    my $uc = uc($c);
    my $flag = ($uc eq $c)?2:1;
    $m{$uc} |= $flag;
  }
  my @k = sort grep {$m{$_} == 3} keys %m;
  return $k[-1] || '';
}
