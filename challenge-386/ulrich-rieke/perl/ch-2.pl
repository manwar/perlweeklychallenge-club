#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub parse {
   my $rational = shift ;
   my @parts ;
   my $pointpos = index( $rational , "." ) ;
   push( @parts , substr( $rational , 0 , $pointpos )) ;
   my $bracketopen = index( $rational , "(" ) ;
   if ( $bracketopen != -1 ) {
      push( @parts , substr( $rational , $pointpos + 1 , $bracketopen - 
               $pointpos - 1 )) ;
      push( @parts , substr( $rational, $bracketopen + 1 , length( $rational ) - 
               $bracketopen - 2 )) ;
   }
   else {
      push( @parts , "" ) ;
      push( @parts , "" ) ;
   }
   return @parts ;
}

sub areSame {
   my $firstnumber = shift ;
   my $secondnumber = shift ;
   my @firstparts = parse( $firstnumber ) ;
   my @secondparts = parse( $secondnumber ) ;
   if ( $secondnumber =~ /^\d+\.$/ ) {
      if ( ($firstparts[1] =~ /^9+$/ || $firstparts[1] eq "" ) && 
            ($firstparts[2] =~ /^9+$/ )) {
         if ( $secondparts[0] + 0 == $firstparts[0] + 1 ) {
            return "true" ;
         }
         else {
            return "false" ;
         }
      }
   }
   else {
      my $firstexpanded = $firstparts[0] . "." . $firstparts[1] ;
      my $secondexpanded = $secondparts[0] . "." . $secondparts[1] ;
      if ( length( $firstparts[2] ) != 3 ) {
         $firstexpanded .= ( $firstparts[2] x 4 ) ;
      }
      else {
         $firstexpanded .= ( $firstparts[2] x 3 ) ;
      }
      if ( length( $secondparts[2] ) != 3 ) {
         $secondexpanded .= ( $secondparts[2] x 4 ) ;
      }
      else {
         $secondexpanded .= ( $secondparts[2] x 3 ) ;
      }
      if ( substr( $firstexpanded , 0 , length( $secondexpanded )) eq $secondexpanded
            || substr( $secondexpanded , 0 , length( $firstexpanded )) eq 
            $firstexpanded ) {
         return "true" ;
      }
      else {
         return "false"  ;
      }
   }
}

say "Enter a rational number!" ;
my $rat1 = <STDIN> ;
chomp $rat1 ;
say "Enter another rational number!" ;
my $rat2 = <STDIN> ;
chomp $rat2 ;
say areSame( $rat1 , $rat2 ) ;
