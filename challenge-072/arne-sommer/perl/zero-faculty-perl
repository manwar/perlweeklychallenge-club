#! /usr/bin/env perl

use strict;
use feature 'say';

my $N = shift(@ARGV) // die 'Please specify $N';
my $verbose;
my $upto;

while ($N eq "--verbose" || $N eq "-v" || $N eq "--upto" || $N eq "-u")
{
  $verbose++ if $N eq "--verbose" || $N eq "-v";
  $upto++    if $N eq "--upto"    || $N eq "-u";

  $N = shift(@ARGV) // die 'Please specify $N';
}

die '$N must be an integer >= 1' unless int($N) == $N && $N >= 1;

my $faculty = 1;

for my $value (1 .. $N)
{
  $faculty *= $value;
  
  if ($upto || $value == $N)
  {
    say ": $value Faculty: $faculty" if $verbose;
    $faculty =~ /(0*)$/;
    say length $1;
  }
}
