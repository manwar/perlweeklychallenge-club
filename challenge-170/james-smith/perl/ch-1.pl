#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Math::Prime::Util qw(next_prime);
use Data::Dumper qw(Dumper);
use bigint;

my(@x)= my $p = 1;

push @x, $x[-1] * ($p = next_prime $p) for 1..100;

say sprintf '%300s', th($_) for @x;

sub th { scalar reverse( (reverse $_[0]) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) }

