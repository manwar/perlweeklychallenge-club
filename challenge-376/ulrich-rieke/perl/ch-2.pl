#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
 
say "Enter a text!" ;
my $line = <STDIN> ;
$line =~ s{\b([a-z]+)\b((?:\s)+)(<[^>]+>)(\1)(<[^>]>)}{\[$1\]$2$3\[$4\]$5}igx ;
$line =~ s{\b([a-z]+)\b((?:\s)+)\b(\1)\b}{\[$1\]$2\[$3\]}igx ; 
$line =~ s{\b([a-z]+)(\\n)(\1)}{\[$1\]$2\[$3\]}igx ;
$line =~ s{(<[^>]+>)([a-z]+)(<[^>]+>)((?:\s)+)(\2)}{$1\[$2\]$3$4\[$5\]}igx ; 
my @lines = split( /\\n/ , $line ) ;
my @selected = grep { $_ =~ /\[[^]]+\]/ } @lines ;
if ( not @selected ) {
   say '""'  ;
}
if (scalar( @selected ) > 1) {
   say $selected[0] . "\\n" . $selected[1] ;
}
if (scalar( @selected ) == 1 ) {
   say $selected[0] ;
}
