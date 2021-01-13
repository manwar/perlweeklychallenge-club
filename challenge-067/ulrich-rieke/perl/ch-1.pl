#!/usr/bin/perl ;
use strict ;
use warnings ;
use Algorithm::Combinatorics qw ( combinations ) ;

my $m = $ARGV[0] ;
my $n = $ARGV[ 1 ] ;
my @list = (1..$m) ;
my $iter = combinations( \@list , $n ) ;
while ( my $p = $iter->next ) {
  print "(" ;
  map { print } @{$p} ;
  print ")\n" ;
}
