#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string according to given limitations!" ;
my $string = <STDIN> ;
chomp $string ;
#separate checking of %} at the end since both { and } in the same
#regex do weird things
if ( $string =~ /%}$/ && $string =~
      /^{%\s+(\w+?)\s+(((\w+)=("*[a-z"\\A-Z\d\s]+"*)\s*)*)\s+/ ) {
   say "{" ;
   say "    name => $1," ;
   say "    fields => {" ;
   if ( $2 ) {
      my $text = $2 ;
      while ( $text =~ /\G\s*(\w+)=(".+"\s*|\d+\s*)/g ) {
	 print "       $1 => " ;
	 if ( $2 =~ /^\d+$/ ) {
	    say $2 . ",";
	 }
	 else {
	    say "$2," ;
	 }
      }
   }
   say "    }" ;
   say "}" ;
}
