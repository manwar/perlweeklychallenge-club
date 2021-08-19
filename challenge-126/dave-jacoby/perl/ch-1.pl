#!/usr/bin/env perl

use strict ;
use warnings ;
use feature qw{ say postderef signatures state } ;
no warnings qw{ experimental } ;

use Carp;
use Getopt::Long;

my $n = 15;
GetOptions( 
    'n=i' => \$n
);

croak 'Out of Range!' if $n < 1;

say join ', ' , dont_contain( $n );

sub dont_contain ($n ) {
    return grep { ! /1/ } 1 .. $n
}
