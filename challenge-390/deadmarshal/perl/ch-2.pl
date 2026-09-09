#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 7;

sub order_characters{
  my ($s,$k) = @_;
  if ($k == 1) {
    my $n = length($s);
    my $doubled = $s . $s;
    my $best = substr($doubled,0,$n);
    foreach my $i(1..$n-1) {
      my $candidate = substr($doubled,$i,$n);
      $best = $candidate if $candidate lt $best
    }
    return $best
  } else {
    return join('',sort split '',$s)
  }
}

is order_characters('dbca',1),'adbc','Example 1';
is order_characters('geeks',2),'eegks','Example 2';
is order_characters('cbaed',3),'abcde','Example 3';
is order_characters('fedcba',4),'abcdef','Example 4';
is order_characters('perl',1),'erlp','Example 5';
is order_characters('oloolooo',1),'looloooo','Example 6';
is order_characters('oloooolo',1),'looloooo','Example 7';

done_testing();

