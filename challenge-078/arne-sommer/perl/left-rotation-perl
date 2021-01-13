#! /usr/bin/env perl

use feature 'say';
use feature 'signatures';
use Perl6::Junction 'all';

no warnings qw(experimental::signatures);

my @A = split(" ", $ARGV[0]); 
my @B = split(" ", $ARGV[1]);  

die 'Specify @A' unless @A;
die 'Specify @B' unless @B;

die '@A must be positive numbers only' unless all(@A) > 0;
die '@B must be legal indices only'    unless 0 <= all(@B) && all(@B) <= $#A;

map { say '[' . join(' ', do_rotate($_, @A)) . ']' } @B;

sub do_rotate ($length, @array)
{
  push(@array, shift @array) for 1..$length;
    
  return @array;
}
