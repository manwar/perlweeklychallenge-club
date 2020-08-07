#! /usr/bin/env perl

use strict;
use feature 'say';

my $verbose;

if ($ARGV[0] eq "--verbose" || $ARGV[0] eq "-v")
{
  $verbose++;
  shift(@ARGV);
}

my $filename = shift(@ARGV) // die 'Please specify a file';

my $A = shift(@ARGV) // die 'Please specify $A';
my $B = shift(@ARGV) // die 'Please specify $B';

die '$A must be an integer >= 1'  unless int($A) == $A && $A >= 1;
die '$B must be an integer >= $A' unless int($B) == $B && $B >= $B;

my $count = 0;

open my $in, $filename or die "$filename: $!";

while (my $line = <$in>)
{
  $count++;

  say ": Considering line $count: $line" if $verbose;

  next if $count < $A;

  print $line;
  
  last if $count == $B;
}

close $in;
