#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(aos([10, 20, 30, 40, 50, 60, 70, 80, 90]),[10, 15, 20, 25, 30, 35, 40, 45, 50],'example 1');

sub aos(@m) {
  my $n=0;
  my $t=0;
  my @o;
  for @m -> $i {
    $t+=$i;
    $n++;
    push @o,floor($t/$n);
  }
  return @o;
}
