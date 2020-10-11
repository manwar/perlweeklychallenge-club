#!/usr/bin/perl

use strict;
use warnings;

die "usage: ./ch-1.pl [number]\n"
    unless scalar @ARGV;

my $input = shift @ARGV;

my $set_bits;
foreach my $num (1 ... $input) {
    my $binary = sprintf "%b", $num;
    my $count = $binary =~ tr/1//;
    $set_bits += $count;
}
print $set_bits % 1000000007, "\n";
