#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-08-05
# Week: 020
#
# Task #1
#
# Write a script to accept a string from command line and split it on
# change of character. For example, if the string is “ABBCDEEF”, then it
# should split like “A”, “BB”, “C”, “D”, “EE”, “F”.

use strict;
use warnings;
use feature qw/ say /;
use Test::More;

my $test_string = "ABBCDEEF";
my @test_result = split_string_on_character_change($test_string);

ok( scalar @test_result == 6, "test size of array" );
ok( $test_result[0] eq "A",   "first element is \"A\"" );
ok( $test_result[4] eq "EE",  "fifth element is \"EE\"" );

done_testing();

my $input_string = $ARGV[0];

sub split_string_on_character_change {
    my $string = shift;
    my @splits = do {
        my $i;
        grep { ++$i % 2 } $string =~ m/((.)\g{-1}*)/g;
    };
    return @splits;
}

my @strings = split_string_on_character_change($input_string);

for (@strings) {
    say $_;
}
