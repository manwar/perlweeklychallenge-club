#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

#even if this is a Perl site , remember the old saying: Oh , for this problem
#we have regular expressions! Now he had two problems...!
sub is_valid {
   my $word = shift ;
   my @conditions ;
   if ( $word =~ /^\D+$/ ) {
      push( @conditions, 1 ) ;
   }
   if ( $word =~ /\-/ ) {
      if (index( $word , "-" ) != length($word) - 1 && (scalar( grep { $_ eq '-' } 
            split( // , $word )) == 1) && ($word =~ /[a-z]\-[a-z]/)) {
         push( @conditions , 1 ) ;
      }
      else {
         push( @conditions , 0 ) ;
      }
   }
   else {
      push( @conditions , 1 ) ;
   }
   if ( $word =~ /[!,\.]/ ) {
      if ( scalar( grep { $_ eq '!' || $_ eq '.' || $_ eq ',' } split( // , $word )) == 1
            && $word =~ /[!,\.]$/ ) {
         push( @conditions, 1 ) ;
      }
      else {
         push( @conditions , 0 ) ;
      }
   }
   else {
      push( @conditions, 1 ) ;
   }
   if ( all{ $_ == 1 } @conditions ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

   
say "Enter a sentence!" ;
my $sentence = <STDIN> ;
chomp $sentence ;
say scalar grep { is_valid( $_ ) } split( /\s/ , $sentence ) ;
