#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my @letters = split( '' , $word ) ;
my @uppers = grep { $_ =~ /[A-Z]/ } @letters ;
if ( @uppers ) {
   my @selected ;
   for my $aChar ( @uppers ) {
      my $lower = chr( ord( $aChar ) + 32 ) ;
      if ( $word =~ /$lower/ ) {
	 push @selected , $aChar ;
      }
   }
   if ( @selected ) {
      my @sorted = sort @selected ;
      say $sorted[-1] ;
   }
   else {
      say "''" ;
   }
}
else {
   say "''" ;
}
