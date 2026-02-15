#!/usr/bin/perl
use 5.038;
use warnings;

my ($str, $width) = @ARGV;

my $output = '*' x $width;
substr $output, ($width - length $str) / 2, length $str,  $str;
say $output;
