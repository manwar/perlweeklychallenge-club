#!/usr/bin/perl
use 5.038;
use warnings;

my ($int) = @ARGV;
$int =~ s/^/0 x (3 - (length $int) % 3)/e;
$int = join q{,}, ($int =~ /(.{3})/g);
$int =~s/^0+,*//;
say $int;