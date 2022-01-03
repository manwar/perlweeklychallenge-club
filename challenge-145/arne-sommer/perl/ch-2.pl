#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util 'uniq';

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $s = $ARGV[0] // 'redivider';

my @result;
my $length = length($s);

for my $start (0 .. $length)
{
  push(@result, substr($s, $start, 1));
  
  next if $start > $length -2;
  
  for my $stop ($start +1 .. $length -1)
  {
    my $candidate = substr($s, $start, $stop - $start +1);
    say ": [$start,$stop] $candidate" if $verbose;
    push(@result, $candidate) if reverse($candidate) eq $candidate;
  }
}

say join(" ", uniq @result);
