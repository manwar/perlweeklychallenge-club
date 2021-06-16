#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

open (my $fh, "<" , "testfile.txt" ) or die "Can't open file!\n" ;
my %linenumbers ;
my @contents ;
while ( my $line = <$fh> ) {
  chomp $line ;
  @contents = split( /,/ , $line ) ;
  $linenumbers{ $contents[ 0 ] }++ ;
}
close $fh ;
for my $i( 1 .. 15 ) {
  unless ( exists $linenumbers{ $i } ) {
      say "line number $i is missing!" ;
  }
}
