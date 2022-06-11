#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( sum ) ;

say "Enter a list of numbers, separated by blanks!" ;
my $row = <STDIN> ;
chomp $row ;
while ( $row !~ /\s*(\d+\s)+/ ) {
  say "List should only contain numbers! Re-enter!" ;
  $row = <STDIN> ;
  chomp $row ;
}
my %created ;
my @numbers = split( /\s/ , $row ) ;
my $iter = combinations( \@numbers, 2 ) ;
while ( my $c = $iter->next ) {
  $created{join( ',' , @{$c})}++ ;
}
my $sum = 0 ;
for my $ref( keys %created ) {
  my @nums = split( /,/ , $ref ) ;
  $sum += $nums[0] & $nums[1] ;
}
say $sum ;
