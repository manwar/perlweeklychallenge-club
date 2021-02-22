#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub enterArray( ) {
  say "Enter integers in one line, separated by white space( <n> <n>)!" ;
  my $line = <STDIN> ;
  chomp $line ;
  my @numbers = split( /\s+/ , $line ) ;
  my %numhash ;
  for my $num ( @numbers ) {
      $numhash{ $num }++ ;
  }
  return sort { $a <=> $b } keys %numhash ;
}

my $N = $ARGV[ 0 ] ;
my @N = enterArray ;
my %numhash ;
my $index ;
foreach my $num ( @N ) {
  $numhash{ $num }++ ;
}
#if $N is in the hash find the position in the array
if ( exists $numhash{ $N } ) {
  my $i = -1 ;
  do {
      $i++ ;
  } until ( $N[ $i ] == $N ) ;
  $index = $i ;
}
#otherwise : count the number of elements that are smaller than $N
else {
  $index = scalar( grep { $_ < $N } @N ) ;
}
say $index ;
