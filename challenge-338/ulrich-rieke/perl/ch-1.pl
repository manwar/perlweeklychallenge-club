#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( max sum ) ;

say "Enter some integers separated by whitespace, <return> to end!" ;
my $line = <STDIN> ;
my @matrix ;
while ( $line !~ /^$/ ) {
   chomp $line ;
   my @numbers = split( /\s+/ , $line ) ;
   push( @matrix , \@numbers ) ;
   $line = <STDIN> ;
}
my @sums ;
for my $row( @matrix ) {
   push( @sums, sum( @{$row} ) ) ;
}
say max( @sums ) ;
