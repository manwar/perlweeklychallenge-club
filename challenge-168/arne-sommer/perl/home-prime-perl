#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';

use Math::Prime::Util 'is_prime';

my $number = int($ARGV[0]) || 0;

die "Please specify an integer >= 2" unless $number =~ /^[1-9]\d*$/ && $number > 1;

$number = join("", factors($number)) until is_prime($number);

say $number;

sub factors ($number)
{
  return (1)       if $number == 1;
  return ($number) if is_prime($number);

  my @factors;

  for my $candidate (grep { is_prime($_) } 2 .. $number / 2)
  {
    while ($number % $candidate == 0)
    {
      push(@factors, $candidate);
      $number /= $candidate;
    }
  }
    
  return @factors;
}
