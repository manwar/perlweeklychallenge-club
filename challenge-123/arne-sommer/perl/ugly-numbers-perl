#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings qw(experimental::signatures);

use Getopt::Long;
use Math::Prime::Util qw/is_prime/;
use Perl6::Junction qw/all any/;

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $n = $ARGV[0] || die "Please specify a positive integer";

die "Please specify a positive integer" unless $n =~ /^[1-9]\d*$/;

my @ugly_seq = (1);

my $candidate = 2;

while (1)
{
  last if @ugly_seq == $n;

  my @prime_factors = factors($candidate);
  push(@ugly_seq, $candidate) if all(@prime_factors) == any(2,3,5);
  $candidate++;
}

say ": Sequence: ", join(", ", @ugly_seq) if $verbose;

say $ugly_seq[$n -1];

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
