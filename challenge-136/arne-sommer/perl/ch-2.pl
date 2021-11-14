#! /usr/bin/env perl

use strict;
use feature 'say';
use List::Util 'sum';
use Algorithm::Combinatorics 'combinations';
use Getopt::Long;

my $verbose = 0;
GetOptions("verbose"  => \$verbose);

my $n = shift(@ARGV) // die "Please specify an integer > 0";
die "Please specify an integer > 0" unless $n =~ /^[1-9]\d*$/;

my @fib = (1, 2);

while (1)
{
  my $new = $fib[-1] + $fib[-2];
  last if $new > $n;
  push(@fib, $new);
}

say ": Fibonacci(<=$n): ", join(", ", @fib) if $verbose;

my $count = 0;

for my $size (1 .. @fib)
{
  for my $perm (combinations(\@fib, $size))
  {
    my $sum = sum(@$perm);

    print ": Sequence: ", join(", ", @$perm), " = $sum" if $verbose;

    if ($sum == $n)
    {
      $count++;
      say " match" if $verbose;
    }
    else
    {
      say "" if $verbose;
    }
  }  
}

say $count;
