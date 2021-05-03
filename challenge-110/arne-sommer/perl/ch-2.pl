#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use File::Slurp;

my $csv_file  = $ARGV[0] // 'persons.csv';

my @lines;

for my $line (read_file($csv_file, chomp => 1))
{
  my @words = split(',', $line);

  for my $index (0 .. @words -1)
  {
     $lines[$index] .= $lines[$index]
       ? ( "," . $words[$index])
       : $words[$index];
  }
}

say $_ for @lines;
