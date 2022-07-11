#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use bigint;

my $n =2;
my @list = ( 2, map { $n = $n*($n-1) + 1 } 2..10 );

say sprintf '%144s', th($_) for @list;

sub th { scalar reverse( (reverse $_[0]) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) }
