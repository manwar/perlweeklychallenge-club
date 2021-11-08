#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my $N = $ARGV[0] // "";


die "Please specify a positive integer" if $N !~ /^[1-9]\d*$/;

my $count   = 1;
my $current = 1;

while ($count < $N)
{
  my @digits  = split(//, reverse($current));
  my $new     = "";
  my $add     = 1;
    
  for my $digit (split(//, reverse($current)))
  {
    if ($add)
    {
      if ($digit <= 2)
      {
        $digit++;
        $add = 0;
      }
      else
      {
        $digit = 1;
      }
    }
      
    $new = $digit . $new;
  }

  $new = "1$new" if $add; 
  $current = $new;

  $count++ unless $current =~ /11/;
}

say $current;