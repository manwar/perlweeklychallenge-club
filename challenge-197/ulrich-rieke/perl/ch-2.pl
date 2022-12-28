#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;
use List::Util qw ( max ) ;

say "Enter at least 3 integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
while ( scalar( @numbers ) < 3 ) {
  say "Please enter at least 3 integers!" ;
  $line = <STDIN> ;
  chomp $line ;
  @numbers = split( /\s/ , $line ) ;
}
my %numberfrequencies ;
map { $numberfrequencies{ $_ }++ } @numbers ;
my $len = scalar( @numbers ) ;
if ( $len > 3 && max( values %numberfrequencies ) >= ($len - 1) ) {
  say "Wiggle condition can't be fulfilled!" ;
}
else {
  my @validPermus ;
  my $iter = permutations(\@numbers ) ;
  while ( my $p = $iter->next ) {
      if ( myCondition( $p ) ) {
    push @validPermus , $p ;
      }
  }
  for my $combi ( @validPermus ) {
      say '(' . join( ',' , @{$combi} ) . ')' ;
  }
}

sub myCondition {
  my $array = shift ;
  if ( scalar( @{$array} ) == 3 ) {
      return ($array->[0] < $array->[1]) && $array->[1] > $array->[2] ;
  }
  if ( scalar( @{$array} ) > 3 ) {
      my $len = scalar( @{$array} ) ;
      for my $i (0.. $len - 2 ) {
    if ( $i % 2 == 0 ) {
        unless ( $array->[$i] < $array->[$i + 1] ) {
          return 0 ;
        }
    }
    else {
        unless ( $array->[$i] > $array->[$i + 1] ) {
          return 0 ;
        }
    }
      }
      return 1 ;
  }
}
