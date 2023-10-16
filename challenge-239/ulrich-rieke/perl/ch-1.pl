#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some strings, separated by blanks!" ;
my $firstLine = <STDIN> ;
chomp $firstLine ;
say "Enter some more strings, separated by blanks!" ;
my $secondLine = <STDIN> ;
chomp $secondLine ;
$firstLine =~ s/\s+//g ;
$secondLine =~ s/\s+//g ;
if ( $firstLine eq $secondLine ) {
   say "true" ;
}
else {
   say "false" ;
}
