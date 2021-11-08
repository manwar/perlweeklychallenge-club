#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#check if the difference of neighbouring numbers is 1
sub isValid {
  my $numbers = shift ;
  my $len = scalar( @$numbers ) ;
  for my $i (0 .. $len - 2 ) {
      if ( ($numbers->[$i] + 1) != ($numbers->[ $i + 1 ]) ) {
    return 0 ;
      }
  }
  return 1 ;
}

sub printResultOnSplit {
  my $nums = shift ;
  say join( ',' , @$nums ) ;
}

my $N = $ARGV[ 0 ] ;
if ( $N < 10 ) {
  die "number must be greater than 9!" ;
}
if ( $N =~ /\b0/ ) {
  die "number should not begin with a zero!\n" ;
}
my $len = length $N ;
my @digits = split( // , $N ) ;
#simple case of a 2-digit-number
if ( $len == 2 ) {
  if ( ($digits[0] + 1) == ($digits[ 1 ]) ) {
      say join( ',' , @digits ) ;
  }
  else {
      say $N ;
  }
}
if ( $len > 2 ) {
  my @numbers ; #for consecutive digits ;
#we accumulate digit by digit in the array numbers and check for validity
  while ( @digits ) {
      push @numbers , splice( @digits, 0 , 1 ) ;
  }
  if ( isValid( \@numbers ) ) {
      printResultOnSplit( \@numbers ) ;
      exit( 0 ) ;
  }
#check for all numbers up to half the length of $N if they are consecutive
#numbers. We check all divisors of $N's length
#if the number of digits is odd, we have to take into account that a
#n + 1-digit-number may be greater by 1 to a n-digit number
  @digits = split( // , $N ) ;
  @numbers = ( ) ;
  my $upperBound ;
  if ( $len % 2 == 1 ) {
      $upperBound = int ( $len / 2 ) + 1 ;
  }
  else {
      $upperBound = $len / 2 ;
  }
  for my $batch( 2 .. $upperBound ) {
      if ( $len % 2 == 1 ) {
    if ( $len % $batch != 0 ) {
        push @numbers, join( '' , splice( @digits, 0 , $batch - 1 ) ) ;
        while ( @digits ) {
          push @numbers, join( '' , splice( @digits, 0 , $batch ) ) ;
        }
        if ( isValid( \@numbers ) ) {
          printResultOnSplit( \@numbers ) ;
          exit( 0 ) ;
        }
    }
      }
      if ( $len % $batch == 0 ) {
    while ( @digits ) {
        push @numbers, join( '' , splice( @digits, 0 , $batch ) ) ;
    }
    if ( isValid( \@numbers ) ) {
        printResultOnSplit( \@numbers ) ;
        exit( 0 ) ;
    }
      }
      @digits = split( // , $N ) ; #we have to re-create this array as it
#was probably consumed in the loop
      @numbers = ( ) ; #and have to erase @numbers in a new loop
  }
  say $N ; #we had no split and so got here in the execution
}
