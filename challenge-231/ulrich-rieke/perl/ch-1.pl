#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max min ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $maxi = max( @numbers ) ;
my $mini = min( @numbers ) ;
my @selected = grep { $_ != $maxi && $_ != $mini } @numbers ;
if ( @selected )  {
   say "(" . join( ',' , @selected ) . ")" ;
}
else {
   say -1 ;
}
