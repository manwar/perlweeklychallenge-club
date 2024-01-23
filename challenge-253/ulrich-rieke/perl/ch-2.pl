#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub count {
   my $numbers = shift ;
   return scalar( grep { $_ == 1 } @$numbers ) ;
}

sub mySorter {
   count( $a->[1] )  <=> count( $b->[1] ) || $a->[0] <=> $b->[0] ;
}

say "Enter some lines of 1 and 0, starting with 1, <return> to end!" ;
my $line = <STDIN> ;
chomp $line ;
my @matrix ;
my $current = 0 ;
while ( $line ) {
   my @numbers = split( /\s/ , $line ) ;
   push( @matrix, [ $current , \@numbers ] ) ;
   $current++ ;
   $line = <STDIN> ;
   chomp $line ;
}
my @sorted = sort mySorter @matrix ;
print "( " ;
for my $p ( @sorted ) {
   print "$p->[0] " ;
}
say ")" ;
