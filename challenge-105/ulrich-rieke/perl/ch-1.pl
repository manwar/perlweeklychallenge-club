#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

die "2 arguments required!" unless ( @ARGV == 2 ) ;
my $N = $ARGV[0] ;
my $k = $ARGV[1] ;
say $k ** (1 / $N ) ;
