#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub tagString {
   my $word = shift ;
   $word =~ s/^\s+// ;
   $word =~ s/\s+$// ;
   my @corrected ;
   my @words = split( /\s/ , $word ) ;
   for my $w ( @words ) {
      $w =~ s/[^a-zA-Z]//g ;
      if ( $w ) {
         push( @corrected , $w ) ;
      }
   }
   my $output = '#' ;
   $output .= lc( $corrected[0] ) ;
   for my $i (1..scalar( @corrected ) - 1 ) {
      $output .= uc( substr( $corrected[$i] , 0 , 1 )) ;
      $output .= lc( substr( $corrected[$i] , 1 )) ;
   }
   if ( length( $output ) > 100 ) {
      $output = substr( $output , 0 , 100 ) ;
   }
   return $output ;
}

say "Enter a sentence!" ;
my $line = <STDIN> ;
chomp $line ;
say tagString( $line ) ;
