#!/usr/bin/env perl

use 5.034;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

sub pandigital ($base, $count) {
  return if $count < 1;
  my $prev =
    (
      ($base ** $base - $base)
      / ($base - 1) ** 2
    )
    + ($base - 1)
    * ($base ** ($base - 2))
    - 1;

  my @results = $prev;

  while (@results < $count) {
    my %digits;
    my @chars = split //, ++$prev;
    $digits{$_} = 1 for @chars;
    next unless keys %digits == $base;
    push @results, join '', @chars;
  }

  return @results;
}

say for pandigital(10, 10);
