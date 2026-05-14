#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;

sub equal_list {
    my ($arr1, $arr2) = @_;
    my $str1 = join '', @$arr1;
    my $str2 = join '', @$arr2;
    return $str1 eq $str2 ? \1 : \0;
}

# Test cases
my @tests = (
    [ ["a", "bc"], ["ab", "c"], 1 ],
    [ ["a", "b", "c"], ["a", "bc"], 1 ],
    [ ["a", "bc"], ["a", "c", "b"], 0 ],
    [ ["ab", "c", ""], ["", "a", "bc"], 1 ],
    [ ["p", "e", "r", "l"], ["perl"], 1 ],
);

for my $test (@tests) {
    my $result = equal_list($test->[0], $test->[1]);
    my $expected = $test->[2];
    say $$result == $expected ? 'ok' : 'not ok';
}
