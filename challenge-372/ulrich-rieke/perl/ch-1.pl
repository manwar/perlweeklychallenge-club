#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a text with words surrounded by spaces!" ;
my $text = <STDIN> ;
chomp $text ;
my $totalspaces = scalar( grep { $_ eq ' ' } split( // , $text ) ) ; 
$text =~ s/^\s+// ;
$text =~ s/\s+$// ;
my $output ;
my @words ;
if ( $text =~ /\s/ ) {
   @words = split( /\s+/ , $text ) ;
   my $len = scalar( @words ) ;
   my $gapspaces = int( $totalspaces / ( $len - 1 )) ;
   for my $i( 0..$len - 2) {
      $output .= $words[$i] ;
      $output .= ' ' x $gapspaces ;
   }
   $output .= $words[-1] ;
   $output .= ' ' x ( $totalspaces * $gapspaces * ( $len - 1 ) ) ;
}
else {
   $output = $text . (' ' x $totalspaces ) ;
}
say $output ;
