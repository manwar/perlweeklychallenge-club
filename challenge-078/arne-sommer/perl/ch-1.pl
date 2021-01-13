#! /usr/bin/env perl

use Perl6::Junction 'all';
use feature 'say';

my @A = @ARGV;

die "Please specify at least one element" unless @A;

die "Integers only" unless all(@A) == qr/^\d+$/;

my @B;

while (@A)
{
  my $a = shift @A;
  push(@B, $a) if $a > all(@A);  
}

say '(' . join(', ', @B)  . ')';
