#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

sub center_text {
    my ($str, $width) = @_;
    my $len = length $str;
    return $str if $len >= $width;
    my $pad_total = $width - $len;
    my $left_pad = int($pad_total / 2);
    my $right_pad = $pad_total - $left_pad;
    return '*' x $left_pad . $str . '*' x $right_pad;
}

my @tests = (
    ["Hi", 5, "*Hi**"],
    ["Code", 10, "***Code***"],
    ["Hello", 9, "**Hello**"],
    ["Perl", 4, "Perl"],
    ["A", 7, "***A***"],
    ["", 5, "*****"],
);

say "Running tests...";
my $all_pass = 1;
for my $i (0..$#tests) {
    my ($str, $width, $expected) = @{$tests[$i]};
    my $got = center_text($str, $width);
    my $status = $got eq $expected ? "PASS" : "FAIL";
    say "Example ", $i+1, ": $status (got '$got', expected '$expected')";
    $all_pass &&= $got eq $expected;
}
say "\nAll tests passed!" if $all_pass;
