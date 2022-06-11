#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;
#if you combine complementary words that contain each letter only once
#one might arrive at the shortest possible pangram

sub isOneLetterWord {
  my $word = shift ;
  my %letters ;
  for my $letter( split ( // , $word ) ) {
      $letters{$letter}++ ;
  }
  return all { $_ == 1 } values %letters ;
}

my $file = "dictionary.txt" ;
my @oneLetterWords ;
open( FH , "< $file") or die "Can't open $file!\n" ;
while ( my $line = <FH> ) {
  chomp $line ;
  if ( isOneLetterWord( $line ) ) {
      push @oneLetterWords, $line ;
  }
}
close( FH ) ;
my %letterFrequencies ;
my @possibleSolutionShort ;
my @possibleSolutionLong ;
for my $letter( 'a' .. 'z') {
  my @sorted = sort { length $a <=> length $b } grep { $_ =~ /\A$letter/ }
    @oneLetterWords ;
    push @possibleSolutionShort , $sorted[0] ;
    push @possibleSolutionLong , $sorted[-1] ;
}
say "If each word solves one letter and contains every letter only once ," ;
say " a possible short solution is:" ;
say join( ',' , @possibleSolutionShort ) ;
my $sum = 0 ;
map { $sum += length $_ } @possibleSolutionShort ;
say "the total length of this pangram would be $sum!" ;
say "and the longest words each containing a letter only once:" ;
say join( ',' , @possibleSolutionLong ) ;
$sum = 0 ;
map { $sum += length $_ } @possibleSolutionLong ;
say "Total number of letters in longest words is $sum!" ;
