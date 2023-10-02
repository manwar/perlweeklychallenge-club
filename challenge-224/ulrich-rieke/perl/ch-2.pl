#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( partitions ) ;

sub isAdditive {
  my $array = shift ;
  my $len = scalar( @$array ) ;
  if ( $len <= 2 ) {
      return 0 ;
  }
  else {
      for my $i ( 2..$len - 1 ) {
    if ( $array->[ $i - 2 ] + $array->[ $i - 1] != $array->[ $i ] ) {
        return 0 ;
    }
      }
      return 1 ;
  }
}

sub concatenate {
  my $array = shift ;
  return join( '' , @$array ) + 0 ;
}

say "Enter a string consisting only of digits 0 to 9!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( // , $line ) ;
if ( isAdditive( \@numbers )) {
  say "true" ;
}
else {
  my $iter = partitions( \@numbers ) ;
  while ( my $c = $iter->next( )) {
      my @currentNumbers ;
      for my $n ( @$c ) {
    push @currentNumbers , concatenate( $n ) ;
      }
      if ( isAdditive( \@currentNumbers )) {
    say "true" ;
    exit( 0 ) ;
      }
  }
  say "false" ;
}
