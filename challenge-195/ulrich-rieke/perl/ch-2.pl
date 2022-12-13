#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @evens = grep { $_ % 2 == 0 } @numbers ;
if ( @evens ) {
  my %frequencies ;
  for my $n ( @evens ) {
      $frequencies{$n}++ ;
  }
  my @sorted  ;
#sort in descending order of frequency
  foreach my $num ( sort { $frequencies{ $b } <=> $frequencies{ $a }} keys
    %frequencies ) {
      push @sorted , $num ;
  }
#that means the front 2 numbers are the largest
  if ( $sorted[0] != $sorted[1] ) {
      say $sorted[0] ;
  }
  else {
      my @sorted = sort { $a <=> $b } @evens ;
      say $sorted[0] ;
  }
}
else {
  say -1 ;
}
