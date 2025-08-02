#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word with lowercase English letters and digits only!" ;
my $word = <STDIN> ;
chomp $word ;
while ( $word =~ /(\D\d)/ ) {
   $word =~ s/$1// ;
}
if ( $word ) {
   say $word ;
}
else {
   say "\"\"" ;
}
