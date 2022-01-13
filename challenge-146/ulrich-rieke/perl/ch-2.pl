#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min  max ) ;

sub createParent {
  my $dividend = shift ;
  my $divisor = shift ;
  my $bdividend = shift ;
  my $bdivisor = shift ;
  my $product = ( $dividend / $divisor ) * ( $bdividend / $bdivisor ) ;
  my $firstMin = min( $dividend , $divisor ) ;
  my $secondMin = min( $bdividend , $bdivisor ) ;
  if ( $product > 1 ) {
      return max( $firstMin , $secondMin ) . '/' .
    min( $firstMin, $secondMin ) ;
  }
  if ( $product < 1 ) {
      return min( $firstMin , $secondMin ) . '/' .
    max( $firstMin , $secondMin ) ;
  }
  if ( $product == 1 ) {
      return "1/1" ;
  }
}

sub createBrother {
  my @brotherresult ;
  my $brotherDividend ;
  my $brotherDivisor ;
  my $dividend = shift ;
  my $divisor = shift ;
  my $maximum = max( $dividend , $divisor ) ;
  my $minimum = min( $dividend , $divisor ) ;
  if ( $maximum == $dividend ) {
      $brotherDivisor = $maximum ;
      $brotherDividend = $maximum - $minimum ;
  }
  else {
      $brotherDividend = $maximum ;
      $brotherDivisor = $maximum - $minimum ;
  }
  push @brotherresult , $brotherDividend, $brotherDivisor ;
  return @brotherresult ;
}

say "Enter a fraction as dividend / divisor!" ;
my $member = <STDIN> ;
chomp $member ;
while ( $member !~ /\A(\d+)\s*\/\s*(\d+)\z/ ) {
  say "Please enter a fraction as dividend / divisor!" ;
  $member = <STDIN> ;
  chomp $member ;
}
if ( $member =~ /\A(\d+)\s*\/\s*(\d+)\z/ ) {
  my $dividend = $1 ;
  my $divisor = $2 ;
  if ( $dividend eq '1' && $divisor eq '1' ) {
      say "parent =  and grandparent = " ;
  }
  elsif ( $dividend / $divisor == 0.5 || $dividend / $divisor == 2 ) {
      say "parent = 1/1 and grandparent = !" ;
  }
  else {
      my @brotherFraction = createBrother( $dividend , $divisor ) ;
      my $parent = createParent( $dividend , $divisor , $brotherFraction[ 0 ] ,
        $brotherFraction[1] ) ;
      my $grandParent ;
      if ( $parent =~ /\A(\d+)\/(\d+)\z/ ) {
    my @uncle = createBrother( $1 , $2 ) ;
    $grandParent = createParent( $1 , $2, $uncle[ 0 ] , $uncle[ 1 ] ) ;
      }
      if ( $parent ) {
    print "parent = $parent" ;
      }
      if ( $grandParent ) {
    say " and grandparent = $grandParent" ;
      }
  }
}
