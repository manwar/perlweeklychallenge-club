#!/usr/bin/perl -s

use v5.16;
use warnings;
use Math::Prime::Util qw(vecsum todigits);

our $base;
$base ||= 10;

die <<EOS unless @ARGV;
usage: $0 [-base=B] N

-base=B
    find Niven numbers in base B

N
    find Niven numbers up to N

EOS


# Implementation

for (1 .. shift) {
    say unless $_ % vecsum todigits $_, $base;
}
