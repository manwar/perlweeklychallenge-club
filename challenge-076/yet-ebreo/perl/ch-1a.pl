#! /usr/bin/perl
use strict;
use feature 'say';

use Math::Prime::Util qw(partitions is_prime forpart);
my $min = 1e9;
my $res = "";
my $N   = $ARGV[0] || 9;
$"      = "+";

forpart { (!grep  !is_prime($_), @_ ) && ($#_ < $min) && (($min, $res) = ($#_,"@_=$N")) } $N;

say $res