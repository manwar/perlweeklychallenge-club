#!/usr/bin/env perl

# Challenge 047
#
# TASK #1
# Roman Calculator
# Write a script that accepts two roman numbers and operation. It should then
# perform the operation on the give roman numbers and print the result.
#
# For example,
#
# perl ch-1.pl V + VI
# It should print
#
# XI

use Modern::Perl;
use Math::Roman qw(roman);

@ARGV==3 or die "Usage: ch-1.pl xxx +- xxx\n";

my $a = roman($ARGV[0]);
my $op = $ARGV[1];
my $b = roman($ARGV[2]);
if ($op eq '+') {
    say $a+$b;
}
elsif ($op eq '-') {
    say $a-$b;
}
else {
    die "invalid operation\n";
}
