#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

sub alphabetical_order {
    my ($str) = @_;
    my @words = split /\s+/, $str;
    return join ' ', sort @words;
}

my @tests = (
    ["The quick brown fox", "brown fox quick The"],
    ["Hello    World!   How   are you?", "are Hello How World! you?"],
    ["Hello", "Hello"],
    ["Hello, World! How are you?", "are Hello, How World! you?"],
    ["I have 2 apples and 3 bananas!", "2 3 and apples bananas! have I"],
);

say "Running test:";
my $all_pass = 1;
for my $i (0..$#tests) {
    my ($input, $expected) = @{$tests[$i]};
    my $got = alphabetical_order($input);
    my $status = $got eq $expected ? "PASS" : "FAIL";
    say "Example ", $i+1, ": $status (got '$got', expected '$expected')";
    $all_pass &&= $got eq $expected;
}

say "\nAll tests passed!" if $all_pass;
