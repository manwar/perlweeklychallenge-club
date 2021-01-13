#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;

sub task1 :prototype(\@$) {
  my ($N, $A) = @_;
  my $len = @$N;
  for (my $m = 0; $m < $len; $m += 1) {
    for (my $n = 0; $n < $len; $n += 1) {
      next if $m == $n;
      if ($N->[$m] - $N->[$n] == $A) {
        say "1 as $N->[$m] - $N->[$n] = $A";
        return;
      }
    }
  }
  say 0;
}

my @N = (10, 8, 12, 15, 5);
task1 @N, 7;
@N = (1, 5, 2, 9, 7);
task1 @N, 6;
@N = (10, 30, 20, 50, 40);
task1 @N, 15;
