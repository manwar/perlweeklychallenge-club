#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub condition {
   my $word = shift ;
   my %frequencies ;
   for my $letter( split( // , $word ) ) {
      $frequencies{$letter}++ ;
   }
   my @sorted = sort keys %frequencies ;
   return join( '' , @sorted ) eq "aeiou" ;
}

say "Enter a string!" ;
my $word = <STDIN> ;
chomp $word ;
my $len = length $word ;
my @solution ;
for my $start (0..$len - 5) {
   for my $end( $start + 5..$len ) {
      my $substring = substr( $word , $start , $end - $start ) ;
      if ( condition( $substring ) ) {
         push( @solution , $substring ) ;
      }
   }
}
print '(' ;
if ( @solution ) {
   print join( ',' , @solution ) ;
}
say ')' ;


