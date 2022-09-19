#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all);

sub has_same_digits{
  use integer;
  my ($m, $n) = @_;
  my @arr = (0) x 10;
  while($m){$arr[$m % 10]++; $m /= 10}
  while($n){$arr[$n % 10]--; $n /= 10}
  if(!all{$_ == 0} @arr){
    return 0;
  }
  return 1;
}

sub smallest_permuted_multiples{
  my $i = 10;
  while (1) {
    my $found = 1;
    foreach my $j (2..6) {
      if (!has_same_digits($i, $i * $j)) {
	$found = 0;
	last;
      }
    }
    return $i if $found;
    $i++;
    }
}

print smallest_permuted_multiples;
