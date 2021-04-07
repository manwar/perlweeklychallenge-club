#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isSelfDescriptive {
  my $number = shift ;
  my $len = length $number ;
  for my $pos (0 .. $len - 1 ) {
      if ( substr( $number, $pos , 1 ) != myCount( $pos , $number ) ) {
    return 0 ;
      }
  }
  return 1 ;
}

sub myCount {
  my $num = shift ;
  my $numberstring = shift ;
  my $count = 0 ;
  my $len = length $numberstring ;
  my $found = index( $numberstring , $num , 0 ) ;
  while ( $found != -1 ) {
      $count++ ;
      if ( $found + 1 < $len ) {
    $found = index( $numberstring , $num , $found + 1 ) ;
      }
      else {
    last ;
      }
  }
  return $count ;
}

#function addOne adds 1 to a number in a given base. We have to consider that
#the maximum digit in the number string must be b - 1 if b is the base
#due to a lack of formal conversion functions in Perl I allow myself to limit
#the search up to and including base 10
sub addOne {
  my $base = shift ;
  my $number = shift ;
  my $reversed = reverse $number ;
  my $i = 0 ;
  while ( (substr( $reversed , $i , 1 ) + 0) == $base - 1 ) {
      $i++ ;
      if ( $i == $base ) {
    $number = '0' x $base  ;
    return $number ;
      }
  }
  substr( $reversed , $i , 1 ) = (substr( $reversed , $i , 1 ) + 1) . '' ;
#set any previous positions to 0
  if ( $i > 0 ) {
      for my $j ( 0 .. $i - 1 ) {
    substr( $reversed , $j , 1 ) = '0' ;
      }
  }
  return reverse $reversed ;
}

say "Enter a base ( 4 is minimum!) " ;
my $base = <STDIN> ;
chomp $base ;
while ( $base < 4 ) {
  say "The base must be greater than or equal to 4! Re-enter base!" ;
  $base = <STDIN> ;
  chomp $base ;
}
my $current = '1' . ('0' x ( $base - 1 ) ) ;
my @selfDescriptives ;
while ( scalar @selfDescriptives < 3 ) {
  $current = addOne( $base, $current ) ;
  if ( $current eq ('0' x $base ) ) {
      $base++ ;
      $current = '1' . ( '0' x ( $base - 1 ) ) ;
  }
  if ( isSelfDescriptive( $current )) {
      push @selfDescriptives, $current ;
  }
}
say join( ", " , @selfDescriptives) ;
