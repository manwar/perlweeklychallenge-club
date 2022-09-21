#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an even number of integers!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
say join( ',' , @numbers ) ;
while ( scalar( @numbers ) % 2 != 0 ) {
  say "For the purposes of this task enter an even number of integers!" ;
  $line = <STDIN> ;
  chomp $line ;
  @numbers = split( /\s+/ , $line ) ;
}
my @list ;
my @solution ;
while ( @numbers ) {
  my $first = shift @numbers ;
  my $second = shift @numbers ;
  my $pair = [$first , $second] ;
  push @list , $pair ;
}
my %seen ;
print "[" ;
for my $p ( @list ) {
  unless ( exists $seen{ "$p->[0],$p->[1]" } ) {
      print "[" . $p->[0] . ',' . $p->[1] . "]" ;
  }
  $seen{ "$p->[0],$p->[1]" }++ ;
}
say "]" ;
