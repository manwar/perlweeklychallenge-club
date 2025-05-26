#!/usr/bin/perl
use v5.38;

my ($str, $i) = @ARGV;

$str =~ s/-//g;

my $pos = 0;
my $len = length $str;

my @segments = substr($str, $pos, $len % $i) || ();
$pos += $len % $i;

while ($pos < $len) {
    push @segments, (substr($str, $pos, $i));
    $pos += $i;
}

say join q{-}, @segments;