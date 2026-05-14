#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;

sub equal_strings_ops {
    my ($s1, $s2, $s3) = @_;

    my $min_len = length($s1);
    $min_len = length($s2) if length($s2) < $min_len;
    $min_len = length($s3) if length($s3) < $min_len;

    my $i = 0;
    while ($i < $min_len) {
        my $ch = substr($s1, $i, 1);
        last if $ch ne substr($s2, $i, 1) || $ch ne substr($s3, $i, 1);
        ++$i;
    }

    return -1 if $i == 0;
    return (length($s1) - $i) + (length($s2) - $i) + (length($s3) - $i);
}

# Test cases from the blog
my @tests = (
    ['abc', 'abb', 'ab', 2],
    ['ayz', 'cyz', 'xyz', -1],
    ['yza', 'yzb', 'yzc', 3],
);

for my $test (@tests) {
    my $result = equal_strings_ops($test->[0], $test->[1], $test->[2]);
    my $expected = $test->[3];
    say $result == $expected ? 'ok' : "not ok: got $result, expected $expected";
}
