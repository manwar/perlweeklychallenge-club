#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findIndex { #index of a word in an array
  my $array = shift ;
  my $word = shift ;
  my $pos = 0 ;
  while ( $array->[$pos] ne $word ) {
      $pos++ ;
  }
  return $pos ;
}

say "Enter some unique strings, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstWords = split( /\s/ , $line ) ;
say "Enter more unique strings, separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @secondWords = split( /\s/ , $line ) ;
my %wordHash ;#this hash counts the occurrences of each word
map { $wordHash{$_}++ } @firstWords ;
map { $wordHash{ $_ }++ } @secondWords ;
my @selectedWords = grep { $wordHash{ $_ } > 1 } keys %wordHash ;
if ( @selectedWords ) {
  my @wordIndices ; #contains a pair of word and the index sum from both arrays
  for my $word ( @selectedWords ) {
      push @wordIndices , [ $word , findIndex(\@firstWords, $word ) +
    findIndex(\@secondWords, $word ) ] ;
  }
#sort by index sum, ascending
  my @sorted = sort { $a->[1] <=> $b->[1] } @wordIndices ;
  my $minimum = $sorted[0]->[1] ;#minimum number of occurrences in both array
#take all those words that occur $minimum times in both arrays combined
  my @allWords = map { $_->[0] } grep { $_->[1] == $minimum } @sorted ;
  print "(" ;
  print join( ',' , sort { $a cmp $b } @allWords ) ;
  say ")" ;
}
else {
  say "()" ;
}
