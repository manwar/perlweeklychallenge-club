#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(sum);
use feature 'signatures';

no warnings qw(experimental::signatures);

my $limit   =   8;
my $delta   = 100,
my $verbose =   0;

GetOptions("limit" => \$limit, "delta" => \$delta, "verbose" => \$verbose);

my @result;
my $number = 0; 

while (++$number)
{
  my $n = $number;
  my $i = $delta;
  
  while ($n != 1 && $i > 0) 
  {
    $n = happy($n);
    $i--;
  }

  if ($verbose)
  {
    $n == 1
      ? say ": $number is happy (in " . ( 100 - $i ) . " step(s))"
      : say ": $number is not happy";
  }
  
  push(@result, $number) if $n == 1;
  
  last if @result == $limit;
}

say join(", ", @result);

sub happy ($number)
{
  return sum(map { $_ ** 2 } split(//, $number));
}

