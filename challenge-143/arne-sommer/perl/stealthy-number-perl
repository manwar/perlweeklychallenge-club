#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

use Getopt::Long;
use Algorithm::Combinatorics qw(combinations);

no warnings qw(experimental::signatures);

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $n = $ARGV[0] // exit;

die("Not a positive integere") unless $n =~ /^[1-9][0-9]*$/;

my @pairs = divisor_pairs($n);

if (@pairs > 1)
{
  for my $pair (combinations(\@pairs, 2))
  {
    my $a = @$pair[0]->[0];
    my $b = @$pair[0]->[1];
    my $c = @$pair[1]->[0];
    my $d = @$pair[1]->[1];

    if ($a * $b == $c * $d && $a * $b == $n && $a + $b == $c + $d + 1)
    {
      say ": a:$a b:$b c:$c d:$d" if $verbose;
      say 1;
      exit;
    }
  }
}

say 0;

sub divisor_pairs ($number)
{
  my @divisors;
  my %seen;

  for my $candidate (1 .. $number/2) 
  {
    if ($number % $candidate == 0)
    {
      my $b = $number / $candidate;

      next if $seen{$candidate};

      $seen{$b} = 1;
      
      push(@divisors, [$candidate, $b]);
    }
  }

  return @divisors;
}
