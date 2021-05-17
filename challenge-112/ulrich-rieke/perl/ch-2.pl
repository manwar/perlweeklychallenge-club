#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;
use List::Util qw ( all ) ;

my $steps = $ARGV[0] ;
my $output = 0 ;
my $stepnumber ;
my $maxtwonumber ; #how many 2's combine to the given number
my %allcombis ; #hash for the combinations, contains number strings
#the strategy is to combine as many 2's as possible and to then sequentially
#reduce the numbers of 2, all summing up to the number of steps. Then we add
#the number of all possible permutations
#we convert the permutations to strings in order to hash them
#in this way, we can tell different permutations from each other
if ( $steps % 2 == 0 ) {
  $maxtwonumber =  $steps / 2 ;
  $stepnumber = $maxtwonumber ;
}
else {
  $maxtwonumber = int ( $steps / 2 ) ;
  $stepnumber = $maxtwonumber + ( $steps - $maxtwonumber * 2 ) ;
}
#the maxinum stepnumber is $steps if we only take 1 step at a time
while ( $stepnumber <= $steps ) {
  my @numbers ;
  for my $i ( 0 .. $maxtwonumber - 1 ) { #add as many 2's as possible
      push @numbers, 2 ;
  }
  for my $i ( 0 .. ($steps - $maxtwonumber * 2) - 1 ) {
      push @numbers , 1 ; #for the rest, add 1's
  }
  if ( all { $_ == $numbers[ 0 ] } @numbers ) {
      $output++ ; #all numbers are equal, we found one combination of steps
  }
  else {
      my $iter = permutations( \@numbers ) ;#the algorithm swaps places and
#does not necessarily produce different sequences of numbers
#so we convert numbers into number strings
#if numbers are greater than 10 we separate the digits with a hyphen to
#arrive at a reproducible number string
      while ( my $p = $iter->next ) {
    my $numberstring ;
    for my $num ( @$p ) {
        if ( $num > 10 ) {
          $numberstring .= join('-' , split(// , $num ) ) ;
        }
        else {
          $numberstring .= $num ;
        }
    }
    $allcombis{ $numberstring }++ ;
      }
  }
  $maxtwonumber-- ; #we reduce the numbers of 2 stepwise and replace them
#with 1's
  $stepnumber += 1 ;
}
$output += scalar keys %allcombis ;
say $output ;
