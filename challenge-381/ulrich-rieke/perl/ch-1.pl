#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#check whether 2 arrays are identical , assuming equal length
sub are_same {
   my $first = shift ;
   my $second = shift ;
   for my $i (0..scalar( @$first ) - 1 ) {
      if ( $first->[$i] != $second->[$i] ) {
         return 0 ;
      }
   }
   return 1 ;
}

say "Enter an n x n matrix of numbers 1 to n!" ;
my $line = <STDIN> ;
chomp $line ;
my @matrixlines ;
while ( $line ) {
   push( @matrixlines, $line ) ;
   $line = <STDIN> ;
   chomp $line ;
}
my $len = scalar( @matrixlines ) ;
my @matrix ;
for my $row( @matrixlines ) {
   push( @matrix , [split( /\s/ , $row)] ) ;
}
my @comparison = (1..$len ) ;
my $row_ok ;
my $col_ok ;
for my $row( @matrix ) {
   my @sorted = sort @$row ;
   if ( are_same( \@sorted , \@comparison ) == 0 ) {
      $row_ok = 0 ;
      last ;
   }
   $row_ok = 1 ;
}
for my $col( 0..$len - 1 ) {
   my @column_numbers ;
   for my $r( 0..$len - 1 ) {
      push( @column_numbers , $matrix[$r]->[$col] ) ;
   }
   my @sorted = sort @column_numbers ;
   if ( are_same( \@sorted , \@comparison ) == 0 ) {
      $col_ok = 0 ;
      last ;
   }
   $col_ok = 1 ;
}
if ( ($row_ok == 1) && ($col_ok == 1) ) {
   say "true" ;
}
else {
   say "false" ;
}
