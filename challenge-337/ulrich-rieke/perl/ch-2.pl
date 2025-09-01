#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter the number of rows and columns separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $rows = $numbers[0] ;
my $cols = $numbers[1] ;
say "Enter locations as as list of comma-separated numbers in brackets!" ;
$line = <STDIN> ;
chomp $line ;
my @pairs ;
while ( $line =~ /\[\s*(\d+)\s*\,\s*(\d+)\s*\]/cg ) {
   push ( @pairs , [$1 , $2] ) ;
}
my @matrix ;
for ( 0..$rows - 1 ) {
   my @matrixrow ;
   for (0..$cols - 1) {
      push( @matrixrow , 0 ) ;
   }
   push( @matrix , \@matrixrow ) ;
}
for my $p ( @pairs ) {
   my @currentrow = @{$matrix[$p->[0]]} ;
   map {$_++} @currentrow ;
   $matrix[$p->[0]] = \@currentrow ;
   for my $r( 0..$rows - 1 ) {
      my $num = $matrix[$r]->[$p->[1]] ;
      $num++ ;
      $matrix[$r]->[$p->[1]] = $num ;
   }
}
my $sum = 0 ;
for my $r (0..$rows - 1 ) {
   for my $c (0..$cols - 1 ) {
      if ( $matrix[$r]->[$c] % 2 == 1 ) {
	 $sum++ ;
      }
   }
}
say $sum ;
