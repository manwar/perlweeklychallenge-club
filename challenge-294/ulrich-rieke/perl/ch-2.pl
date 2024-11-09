#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;

#when working on this task I unfortunately realized that Perl is
#unable to compare the contents of two arrays as Raku can do
#@a == @b means : as many elements in @a as in @b!! It's a bit of
#a shame, although, of course, there are modules for it!!
sub areEqual {
   my $firstArray = shift ;
   my $secondArray = shift ;
   if ( scalar( @{$firstArray}) != scalar( @{$secondArray} ) ) {
      return 0 ;
   }
   else {
      for my $i ( 0..scalar( @{$firstArray} ) - 1 ) {
	 if ( $firstArray->[$i] != $secondArray->[$i] ) {
	    return 0 ;
	 }
      }
      return 1 ;
   }
}

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @for_sorting = @numbers ;
my @sorted = sort {$a <=> $b} @for_sorting ;
my @permus ;
my $iter = permutations( \@sorted ) ;
while ( my $c = $iter->next ) {
   push( @permus , $c ) ;
}
my $len = scalar( @permus ) ;
my $i = 0 ;
while ( not ( areEqual( $permus[$i] , \@numbers ))) {
   $i++ ;
}
if ( $i == $len - 1 ) {
   say '(' . join( ',' , @{$permus[0]} ) . ')' ;
}
else {
   say '(' . join( ',' , @{$permus[$i + 1] } ) .')' ;
}
