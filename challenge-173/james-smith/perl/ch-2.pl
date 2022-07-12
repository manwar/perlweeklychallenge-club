#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use bigint;

my $n=2;
say sprintf '%140s', th($_) for 2,map{$n*=$n-1;++$n}1..9;

#-38-|----#----|----#----|----#----|----
$a=2;say for 2,map{$a*=$a-1;++$a}1..9;

sub th { scalar reverse( (reverse $_[0]) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) }
