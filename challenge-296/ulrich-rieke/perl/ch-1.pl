#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub compress {
   my $word = shift ;
   my $compressed ; #for the compression 
   my $current ; #collection of last characters
   my @terms ; #collection of $current ;
   my $last_char = substr( $word , 0 , 1 ) ;
   $current = $last_char ;
   my $len = length $word ;
   for my $i (1..$len - 1 ) {
      my $next_char = substr( $word , $i , 1 ) ;
      if ( $next_char eq $last_char ) {
	 $current .= $next_char ;
      }
      else {
	 push( @terms , $current ) ;
	 $current = $next_char ;
	 $last_char = $next_char ;
      }
   }
   push( @terms , $current ) ;
   for my $elt ( @terms ) {
      my $ct = length $elt ;
      if ( $ct > 1 ) {
	 $compressed .= $ct ;
	 $compressed .= substr( $elt , 0 , 1 ) ;
      }
      else {
	 $compressed .= substr( $elt , 0 , 1 ) ;
      }
   }
   return $compressed ;
}

sub decompress {
   my $compressed = shift ;
   my $decompressed ;
   my $pos = 0 ;
   while ( $pos != length( $compressed ) ) {
      my $letter = substr( $compressed , $pos , 1 ) ;
      if ( $letter =~ /\d/ ) {
	 $pos++ ;
	 my $theNext = substr( $compressed , $pos , 1 ) ;
	 for (0..$letter - 1) {
	    $decompressed .= $theNext ;
	 }
      }
      else { 
	 $decompressed .= $letter ;
      }
      $pos++ ;
   }
   return $decompressed ;
}

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my $compressed = compress( $word ) ;
say "$word compressed : $compressed!" ;
my $decompressed = decompress( $compressed ) ;
say "and decompressed again : $decompressed!" ;
