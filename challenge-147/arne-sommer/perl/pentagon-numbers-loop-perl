#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings qw(experimental::signatures);

my $a = 1;

while ($a++)
{
  my $b = $a;

  while ($b-- > 1)
  {
    my $penta_a = pentagonial($a);
    my $penta_b = pentagonial($b);

    if (is_pentagonial($penta_a + $penta_b) && is_pentagonial($penta_a - $penta_b))
    {
      say "$penta_b $penta_a";
      exit;
    }
  }
}

sub is_pentagonial($candidate)
{
  my $check = (1 + sqrt(1 + 24 * $candidate)) / 6;
  return int($check) == $check;
}

sub pentagonial($number)
{
  return $number * ( 3 * $number -1) / 2;
}

say "(no match)";
