#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#sort in ascending order of the number of 1 in the rows
#if these are equal sort in ascending order of the numbers that are
#in b's column of a and in a's column of b
sub mySorter {
   scalar( grep { $_ == 1 } @{$a->[1]} ) <=> scalar( grep 
	 { $_ == 1 } @{$b->[1]} ) || 
   ${$a->[1]}[$b->[0]] <=> ${$b->[1]}[$a->[0]] ;
}

say "Enter a quadratic matrix of 0 and 1 , <enter> to end!" ;
my $line = <STDIN> ;
chomp $line ;
my @matrix ;
my $counter = 0 ;
while ( $line ) {
   my @input = split( /\s/ , $line ) ;
   my @row ;
   push( @row , $counter ) ;
   push( @row , \@input ) ;
   push( @matrix , \@row ) ;
   $counter++ ;
   say "Enter a quadratic matrix of 0 and 1 , <enter> to end!" ;
   $line = <STDIN> ;
   chomp $line ;
}
my @sorted = sort mySorter @matrix ;
say "Team " . $sorted[-1][0] ;
