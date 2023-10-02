#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

sub count {
   my $haystack = shift ;
   my $needle = shift ;
   return scalar( grep { $_ == $needle } @$haystack ) ;
}

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @selected = grep { count( \@numbers , $_ ) == 1 } @numbers ;
if ( @selected ) {
   say sum( @selected ) ;
}
else {
   say 0 ;
}
