#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use File::Slurp;
use feature 'signatures';

no warnings 'experimental::signatures';

my $file  = shift(@ARGV) || "paths.txt";
my @paths = read_file($file);
my $first = shift(@paths);

while (@paths)
{
  my $next = shift(@paths);

  $first = common($first, $next);
}

$first =~ /(.*)\//; say $1;

sub common ($a, $b)
{
  my $length = length($a) < length($b) ? length($a) : length($b);

  for my $index (0 .. $length -1)
  {
    return substr($a, 0, $index) unless substr($a, $index, 1) eq substr($b, $index, 1);
  }

  return substr($a, 0, $length);
}
