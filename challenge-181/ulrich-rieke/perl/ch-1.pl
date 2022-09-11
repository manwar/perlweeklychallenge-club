#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

open ( my $fh , '< paragraph.txt' ) or die "Can't open paragraph.txt!\n" ;
my $input ;
while ( my $line = <$fh> ) {
  chomp $line ;
  $input .= ( " " . $line ) ;
}
close( $fh ) ;
my $len = length $input ;
my $output ;
my $startPos = 0 ;
my $pointPos = index( $input , '.' , $startPos ) ;
while ( $pointPos && $pointPos != -1 ) {
  my $sentence = substr( $input , $startPos , $pointPos - $startPos ) ;
  $sentence =~ s/\A\s(.+)\z/$1/ ;
  my @words = split( /\s/ , $sentence ) ;
  $output .= ( join( ' ' , sort { lc( $a ) cmp lc( $b ) } @words ) . '.' ) ;
  $startPos = $pointPos + 1 ;
  $pointPos = index( $input , '.' , $startPos ) ;
}
my $pos = 55 ;
while ( $pos < $len ) {
  while ( substr( $output , $pos , 1 ) ne " " ) {
      $pos++ ;
  }
  substr( $output, $pos , 1 ) = "\n" ;
  $pos += 55 ;
}
$output .= "\n" ;
print $output ;
