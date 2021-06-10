#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub createPairs {
  my $numbers = shift ;
  my $len = scalar @{$numbers} ;
  my @pairs ;
  for my $i (0 .. $len - 2 ) {
      push @pairs , [ $numbers->[$i] , $numbers->[$i + 1]] ;
  }
  return @pairs ;
}

say "Enter integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
if ( scalar @numbers == 1 ) {
  say 0 ;
  exit( 0 ) ;
}
else {
  my @sorted = sort { $b <=> $a } @numbers ;
  my @pairs = createPairs( \@sorted ) ;
  my @differences = sort { $b <=> $a } map { ${$_}[0] - ${$_}[1] } @pairs ;
  say $differences[ 0 ] ;
}
