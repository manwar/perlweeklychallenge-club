#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an even number of integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstNumbers = split( /\s+/ , $line ) ;
say "Enter an even number of integers, again!" ;
$line = <STDIN> ;
chomp $line ;
my @secondNumbers = split( /\s+/ , $line ) ;
my %keyHash ;
my $pos = 0 ;
my $len = scalar( @firstNumbers ) ;
while ( $pos < $len - 1 ) {
   if ( exists ($keyHash{ $firstNumbers[ $pos ] } )) {
      $keyHash{ $firstNumbers[ $pos ] } += $firstNumbers[ $pos + 1 ] ;
   }
   else {
      $keyHash{ $firstNumbers[ $pos ] } = $firstNumbers[ $pos + 1 ] ;
   }
   $pos += 2 ;
}
$pos = 0 ;
$len = scalar( @secondNumbers ) ;
while ( $pos < $len - 1 ) {
   if ( exists ($keyHash{ $secondNumbers[ $pos ] } )) {
      $keyHash{ $secondNumbers[ $pos ] } += $secondNumbers[ $pos + 1 ] ;
   }
   else {
      $keyHash{ $secondNumbers[ $pos ] } = $secondNumbers[ $pos + 1 ] ;
   }
   $pos += 2 ;
}
my @sorted = sort {  $a <=> $b } keys %keyHash ;
print "[ " ;
for my $s ( @sorted ) {
   print "[$s , " . $keyHash{ $s } . "] " ;
}
say "]" ;
