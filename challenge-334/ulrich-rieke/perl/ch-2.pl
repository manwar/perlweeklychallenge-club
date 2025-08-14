#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;
use List::Util qw ( zip ) ;

sub manhattan {
   my $firstpair = shift ;
   my $secondpair = shift ;
   return ( abs( $firstpair->[0] - $secondpair->[0]  ) + 
	 abs( $firstpair->[1] - $secondpair->[1]  )) ;
}

sub isValid {
   my $pair = shift ;
   my $comparison = shift ;
   if ( $pair->[0] == $comparison->[0] || $pair->[1] == $comparison->[1] ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter 2 integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say "Enter some points in brackets separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @pairs ;
while ( $line =~ /\[\s*(\d+)\s*\,\s*(\d+)\s*\]/cg ) {
   push ( @pairs , [$1 , $2] ) ;
}
my @zipped = zip [0..scalar( @pairs ) - 1] , \@pairs ;
my @validPairs = grep { isValid( $_->[1] , \@numbers ) }
 @zipped ;
my $len = scalar( @validPairs ) ;
if ( $len == 0 ) {
   say -1 ;
}
elsif ( $len == 1 ) {
   say 0 ;
}
else {
   my @distances ;
   foreach my $zipped( @zipped ) {
      push( @distances , [$zipped->[0] , manhattan( $zipped->[1] , 
	       \@numbers )] ) ;
   }
   my @sorted = sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] } 
      @distances ;
   say $sorted[0]->[0] ;
}
