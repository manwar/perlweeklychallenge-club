#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use File::Slurp;

my $phonebook  = $ARGV[0] // 'phone-numbers.txt';

for my $line (read_file($phonebook, chomp => 1))
{
  next unless length($line) == 15;
  next unless substr($line, 4, 1) eq ' ';
  next unless substr($line, 5) =~ /^\d{10}$/;

  my $first = substr($line, 0, 4);

  next unless $first =~ /^\d{4}$/ || $first =~ /^\s\+\d\d$/ || $first =~ /^\(\d\d\)$/;

  say $line;
}
