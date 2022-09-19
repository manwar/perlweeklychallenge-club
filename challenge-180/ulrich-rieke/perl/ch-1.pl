#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a sentence!" ;
my $line = <STDIN> ;
chomp $line ;
my $len = length $line ;
my %letterFrequencies ;
for my $i ( 0 .. $len - 1 ) {
  my $letter = substr( $line, $i , 1 ) ;
  $letterFrequencies{$letter}++ ;
}
my @uniques = grep { $letterFrequencies{ $_ } == 1 } keys %letterFrequencies ;
my $minimumFound = $len ;
for my $letter ( @uniques ) {
  my $found = index( $line , $letter ) ;
  if ( $found < $minimumFound ) {
      $minimumFound = $found ;
  }
}
say $minimumFound ;
