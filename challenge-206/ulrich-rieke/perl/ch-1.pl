#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;
use List::Util qw ( min ) ;

sub findDifference {
  my $firstTime = shift ;
  my $secondTime = shift ;
  $firstTime =~ s/0(\d):0(\d)/$1:$2/ ;
  $secondTime =~ s/0(\d):0(\d)/$1:$2/ ;
  my ( $firstHours , $firstMinutes ) = split( /:/ , $firstTime ) ;
  my ( $secondHours, $secondMinutes ) = split( /:/ , $secondTime ) ;
  my $secondary = $secondHours * 60 + $secondMinutes ;
  my $firstary = $firstHours * 60 + $firstMinutes ;
  my $diff = $secondary - $firstary ;
  if ( $diff < 0 ) {
      $secondary += 24 * 60 ;
      $diff = $secondary - $firstary ;
  }
  return $diff ;
}

say "Enter some times in parentheses, hours and minutes separated by ':'!" ;
my $line = <STDIN> ;
chomp $line ;
my @times = split( /\s/ , $line ) ;
my $len = scalar( @times ) ;
my $iter = permutations(\@times) ;
my @differences ;
while ( my $p = $iter->next ) {
  for my $i (0..$len - 2 ) {
      push @differences , findDifference( $p->[$i] , $p->[$i + 1] ) ;
  }
}
say min( @differences ) ;
