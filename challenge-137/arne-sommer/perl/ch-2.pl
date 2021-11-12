#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings qw(experimental::signatures);

my $n = $ARGV[0] // "";

die "Please specify an integer in the range 10 .. 1000" unless $n =~ /^[1-9]\d*$/;
die "Please specify an integer in the range 10 .. 1000" if $n < 10 || $n > 1000;

say is_lychrel($n);

sub is_lychrel ($current)
{
  my $i = 0;
  
  while (1)
  {
    $current = $current + reverse $current;

    return 0 if $current == reverse $current;

    return 1 if $i++ == 500 || $current >= 10_000_000;
  } 
}
