#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Algorithm::Combinatorics 'permutations';
use Array::Utils 'array_minus';  ## Debian/Ubuntu: libarray-utils-perl

my $n = $ARGV[0] // 5;

die "Postive integer only" unless $n =~ /^[1-9]\d*$/;

my @result;

my @base = (0 .. 9);

LOOP:
for my $first (1 .. 9)
{
  my @first = ($first);
  my @rest = array_minus(@base, @first);

  for my $permutation (permutations(\@rest))
  {
    push(@result, ($first . join("", @$permutation)));
    last LOOP if @result == $n;	 
  }
}
    
say join(", ", @result);
    
