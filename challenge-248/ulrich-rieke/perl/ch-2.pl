#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some rows of the same number of integers each!" ;
say "Enter <return> to end entry!" ;
my @matrix ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
   my @numbers = split( /\s/ , $line ) ;
   push @matrix , \@numbers ;
   $line = <STDIN> ;
   chomp $line ;
}
my $matrixlen = scalar( @matrix ) ;
my $rowlen = scalar( @{$matrix[0]} ) ;
my @result ; 
for my $r (0..$matrixlen - 2 ) {
   my @resultline ;
   for my $col( 0..$rowlen - 2 ) {
      my $sum = $matrix[$r]->[$col] + $matrix[$r]->[$col + 1] + 
	 $matrix[ $r + 1]->[$col] + $matrix[$r + 1]->[$col + 1] ;
      push @resultline , $sum ;
   }
   push @result , \@resultline ;
}
say "(" ;
for my $subarray ( @result ) {
   say ( "  (" . join( ',' , @$subarray) . ")" ) ;
}
say ")" ;

