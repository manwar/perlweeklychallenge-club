#!/usr/bin/perl
use 5.038;
use warnings;

my ($str, $char) = @ARGV;

$str =~ s/(^.+?$char)/reverse $1/e;
say $str;