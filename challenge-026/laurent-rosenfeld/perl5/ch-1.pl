#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

@ARGV == 2 or die "This script needs two strings are parameters";
my ($str1, $str2) = @ARGV;
my %letters = map {$_ => 1} grep /[A-Za-z]/, split "", $str1;
my $count = scalar grep { exists $letters{$_}} split "", $str2;
say "$str2 has $count letters from $str1";
