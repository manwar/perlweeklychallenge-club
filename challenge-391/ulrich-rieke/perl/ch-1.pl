#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

say "Enter some sorted integers separated by blanks!" ;
my $firstline = <STDIN> ;
chomp $firstline ;
my @firstnumbers = split( /\s/ , $firstline ) ;
say "Enter some more sorted integers!" ;
my $secondline = <STDIN> ;
chomp $secondline ;
my @secondnumbers = split( /\s/ , $secondline ) ;
for my $num ( @secondnumbers ) {
   push( @firstnumbers , $num ) ;
}
my @sorted = sort { $a <=> $b } @firstnumbers ;
my $len = scalar( @sorted ) ;
if ( $len % 2 == 1 ) {
   say $sorted[floor( $len / 2 )] ;
}
else {
   say (($sorted[$len/2 - 1] + $sorted[$len/2 ]) / 2 ) ;
}
