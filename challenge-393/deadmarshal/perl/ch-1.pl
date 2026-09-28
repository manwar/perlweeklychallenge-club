#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;
use ntheory qw(gcd);

sub pythagoras_multiplied{
  my ($n) = @_;
  my $count = 0;
  for(my $m = 2; $m * $m + 1 <= $n; $m++){
    for(my $k = 1; $k < $m; $k++){
      next if (($m - $k) % 2 == 0) || gcd($m,$k) != 1;
      my $c = $m * $m + $k * $k;
      last if $c > $n && $k == 1;
      next if $c > $n;
      $count += 2 * int($n / $c)
    }
  }
  $count
}

is pythagoras_multiplied(20),12,'Example 1';
is pythagoras_multiplied(7),2,'Example 2';
is pythagoras_multiplied(1),0,'Example 3';
is pythagoras_multiplied(15),8,'Example 4';
is pythagoras_multiplied(30),22,'Example 5';

done_testing();

