#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @selected = grep { $_ % 2 == 0 && $_ % 3 == 0 } @numbers ;
if ( @selected ) {
   my $average = (sum( @selected )) / (scalar( @selected )) ;
   say int( $average ) ; # rather crude , shocked by the absence of 
#reliable functions...
}
else {
   say 0 ;
}
