#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string , starting with 2 letters and then 4 digits, <return> to end!" ;
my @list ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
  while ( $line !~ /^[[:lower:]]{2}[[:digit:]]{4}$/ ) {
      say "String should start with two lower-case letters and the 4 digits!" ;
      $line = <STDIN> ;
      chomp $line ;
  }
  push @list , $line ;
  $line = <STDIN> ;
  chomp $line ;
}
my @output ;
for my $i ( 0 .. $#list ) {
  if ( $i < 10 ) {
      push @output , "0$i" . substr( $list[ $i ] , 2 ) ;
  }
  else {
      push @output , "$i" . substr( $list[ $i ] , 2 ) ;
  }
}
say '(' . join( ',' , @output ) . ')' ;
