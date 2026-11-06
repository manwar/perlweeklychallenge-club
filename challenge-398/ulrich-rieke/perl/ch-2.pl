#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub letter_diffs {
   my $word = shift ;
   my $len = length( $word ) ;
   my @differences ;
   for my $i (1..$len - 1 ) {
      push( @differences , ord( substr( $word , $i , 1 )) - 
            ord( substr( $word , $i - 1 , 1 ))) ;
   }
   return @differences ;
}

say "Enter some words with equal lengths > 1 !" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
#create word differences for every word , store it in a hash , stringified
my %worddiffs ;
for my $word ( @words ) {
   my @diffs = letter_diffs( $word ) ;
   $worddiffs{$word} = join( ',' , @diffs ) ;
}
#count how often every word difference occurs
my %frequencies ;
map { $frequencies{$_}++ } values %worddiffs ;
my $solution ; #word with unique differences ;
for my $word( @words ) {
   my $freq = $worddiffs{$word} ;
   if ( $frequencies{$freq} == 1 ) {
      $solution = $word ;
   }
}
say $solution ;
