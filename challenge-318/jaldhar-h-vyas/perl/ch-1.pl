#!/usr/bin/perl
use v5.38;

my ($str) = @ARGV;
my @groups = grep { length != 1 } ($str =~ /((.)(?:\2{2,}))/gmx);
say @groups ? (join q{, }, map { "\"$_\"" }  @groups) : q{""};
