#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

#in a given word , replace all positions of a question mark with a
#replacement
sub replaceAll {
   my $word = shift ;
   my $question_pos = shift ;
   my $replacement = shift ;
   my @letters = split( // , $word ) ;
   my $n = 0 ;
   for my $pos( @$question_pos ) {
      $letters[$pos] = $replacement->[$n] ;
      $n++ ;
   }
   return join( '' , @letters ) ;
}

say "Enter a word consisting of 0 , 1 and ? only!" ;
my $word = <STDIN> ;
chomp $word ;
if ( $word !~ /\?/ ) {
   say '(' . $word .')' ;
}
else {
   my @question_mark_pos ;
   for my $pos ( 0.. length( $word ) - 1 ) {
      if ( substr( $word , $pos , 1 ) eq "?" ) {
         push( @question_mark_pos , $pos ) ;
      }
   }
   my @replacements ; #contains 0 and 1 for every ? in original word
   for (0..scalar( @question_mark_pos ) - 1 ) {
      push( @replacements , '0' ) ;
      push( @replacements , '1' ) ;
   }
#create as many combinations of length ( number of questionmarks ) from
#@replacements
   my %unique_words ;
   my $iter = combinations( \@replacements , scalar( @question_mark_pos ) ) ;
   while ( my $c = $iter->next ) {
      $unique_words{ replaceAll( $word , \@question_mark_pos , $c ) }++ ;
   }
   my @sorted = sort keys( %unique_words ) ;
   say '(' . join( ',' , @sorted ) . ')' ;
}


