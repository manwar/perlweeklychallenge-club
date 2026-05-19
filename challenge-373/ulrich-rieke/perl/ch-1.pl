#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words separated by blanks!" ;
my $firstline = <STDIN> ;
chomp $firstline ;
say "Enter some more strings separated by blanks!" ;
my $secondline = <STDIN> ;
chomp $secondline ;
$firstline =~ s/\s//g ;
$secondline =~ s/\s//g ;
if ( $firstline eq $secondline ) {
   say "true" ;
}
else {
   say "false" ;
}
