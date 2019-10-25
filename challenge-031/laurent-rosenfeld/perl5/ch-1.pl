#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

die "We need an input of two numbers\n" unless @ARGV == 2;
my ($numerator, $denominator) = @ARGV;
my $result;
eval {
    $result = $numerator / $denominator;
};
die "$@" if $@;
say "Result of division is: $result";
