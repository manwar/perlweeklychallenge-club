#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my @vowels_contained ;
for my $letter ( split( // , $word ) ) {
   if ( $letter =~ /[aeiouAEIOU]/ ) {
      push @vowels_contained , $letter ;
   }
}
my @changed ;
for my $letter ( split( // , $word ) ) {
   if ( $letter =~ /[aeiouAEIOU]/ ) {
      my $next_one = pop @vowels_contained ;
      if ( @changed ) {
	 push @changed , lc( $next_one ) ;
      }
      else {
	 push @changed , uc( $next_one ) ;
      }
   }
   else {
      push @changed , $letter ;
   }
}
say join( '' , @changed ) ;


