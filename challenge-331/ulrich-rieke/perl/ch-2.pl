#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

sub isSwapped {
   my $neighbours = shift ;
   if ( $neighbours->[0][0] eq $neighbours->[1][1] && ( $neighbours->[0][1] eq
	    $neighbours->[1][0] )) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter two words separated by space!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
#the condition can't be true if the words do not contain the same letters
my %firstHash ;
my %secondHash ;
map { $firstHash{$_}++ } split( // , $words[0] ) ;
map { $secondHash{$_}++ } split( // , $words[1] ) ;
#the condition can't be true if the length of the words is not equal
if ( length( $words[0] ) == length( $words[1] ) && keys( %firstHash ) == 
      keys( %secondHash ) ) {
#the idea is: if the words have the same letters and are equally long, then
#zip their letters and form pairs of neighbouring zip pairs. Then the above
#condition of being swapped must be fulfilled in exactly one
   my @firstLetters = split( // , $words[0] ) ;
   my @secondLetters = split( // , $words[1] ) ;
   my @zipped = zip( \@firstLetters , \@secondLetters ) ;
   my @neighbours ;
   for my $pos( 0..length( $words[0] ) - 2 ) {
      push( @neighbours , [$zipped[$pos] , $zipped[$pos + 1]] ) ;
   }
   if ( scalar( grep { isSwapped( $_ ) } @neighbours ) == 1 ) {
      say "true" ;
   }
   else {
      say "false" ;
   }
}
else {
   say "false" ;
}
