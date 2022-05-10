#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Math::Prime::Util qw(next_prime is_prime);

my ($p,$lim,@pal)=(1,@ARGV?$ARGV[0]:1e3);
is_prime(reverse $p) && (push @pal,$p) while ($p=next_prime $p) < $lim;

say for @pal;

$_=1,my$LIM=@ARGV?$ARGV[0]:1e3;
is_prime(reverse$_)&&say while($_=next_prime$_)<$lim;
