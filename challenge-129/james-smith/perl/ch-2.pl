#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use lib '.';
use LL;

my $ch1 = LL->new( 1 )->add( 3 )->add( 2 );
my $ch2 = LL->new( 3 )->add( 1 )->add( 2 );

my $ch3 = LL->new( $ch1->val + $ch2->val );
my ( $p1, $p2 ) = ( $ch1, $ch2 );

while( 1 ) {
  $p1 = $p1->next;
  last unless $p1;
  $p2 = $p2->next;
  $ch3->add( $p1->val + $p2->val );
}

say join "   ", $ch3->flatten;

