#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $name = $ARGV[ 0 ] ;
my $y ; #has to be affixed to the rhyme
my @components = ("bo-b" , "Bonana-fanna fo-f" , "Fee fi mo-m" ) ;
if ( lc( substr( $name , 0 , 1 )) =~ /[aeiou]/ ) {
  $y = lc $name ;
}
else {
  if ( lc( substr( $name , 0 , 1 )) =~ /[bfm]/ ) {
      my $firstLetter = lc ( substr( $name, 0 , 1 ) ) ;
      for my $rhyme ( @components ) {
    my $len = length $rhyme ;
    if ( substr( $rhyme , $len - 1 , 1 ) eq $firstLetter ) {
        $rhyme = substr( $rhyme, 0 , $len - 1 ) ;
    }
      }
  }
  $y = substr( $name , 1 ) ;
}
say "$name, $name, $components[0]$y" ;
map { say "$_$y" } @components[1..2] ;
say "$name!" ;
