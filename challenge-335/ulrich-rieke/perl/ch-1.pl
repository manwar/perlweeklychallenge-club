#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

#common letters of two words
sub intersect {
   my $first = shift ;
   my $second = shift ;
   my %firstfreq ;
   my %secondfreq ;
   my %common ;
   map { $firstfreq{$_}++ } split( // , $first ) ;
   map {$secondfreq{$_}++ } split( // , $second ) ;
   for my $letter( keys %firstfreq ) {
      if ( exists( $secondfreq{$letter} ) ) {
	 $common{$letter}++ ;
      }
   }
   return join( '' , keys %common ) ;
}

say "Enter some words separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
my $len = scalar( @words ) ;
#find common letters of all words , if there are any
my $common = intersect( $words[0] , $words[1] ) ;
for my $i ( 1..$len - 2 ) {
   $common = intersect( $common , $words[$i + 1] ) ;
}
my %commonfrequencies ;#for every letter common to all words , it holds
                       #their respective frequencies
for my $w ( @words ) {
   my %wordfrequencies ;#frequencies of the common letters
   for my $letter( split( // , $w ) ) {
      if ( index( $common , $letter ) != -1 ) {
	 $wordfrequencies{$letter}++ ;
      }
   }
   for my $letter( keys %wordfrequencies ) {
      push( @{$commonfrequencies{$letter}} , $wordfrequencies{$letter} ) ;
   }
}
if ( $common ) {#do we have common letters ?
   my @solution ;
   my @sorted = sort split( // , $common ) ;
   for my $letter( split( // , $common ) ) {
      my $times = min ( @{$commonfrequencies{$letter}} ) ;
      for (1..$times) {
	 push( @solution , $letter ) ;
      }
   }
   say '('. join( ',' , @solution ) . ')' ;
}
else {
   say "()" ;
}
