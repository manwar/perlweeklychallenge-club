#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';

use Math::Prime::Util 'is_prime';
use List::MoreUtils 'duplicates';

my $limit = $ARGV[0] || 500;

die "Please specify a positive integer" unless $limit =~ /^[1-9]\d*$/;

my @result = grep { ! duplicates factors($_) } (1 .. $limit);

say join(", ", @result);

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
