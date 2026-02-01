#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(max);

sub get_value {
    my $str = shift;
    return length($str) unless $str =~ /^\d+$/;
    return 0 + $str;
}

sub test_case {
    my ($name, $strings, $expected) = @_;
    my $got = max(map { get_value($_) } @$strings);
    my $pass = $got == $expected;
    print "$name: ", $pass ? "PASS" : "FAIL", " (got $got, expected $expected)\n";
    return $pass;
}

my @tests = (
    { name => "Example 1", strings => ["123", "45", "6"], expected => 123 },
    { name => "Example 2", strings => ["abc", "de", "fghi"], expected => 4 },
    { name => "Example 3", strings => ["0012", "99", "a1b2c"], expected => 99 },
    { name => "Example 4", strings => ["x", "10", "xyz", "007"], expected => 10 },
    { name => "Example 5", strings => ["hello123", "2026", "perl"], expected => 2026 },
);

print "Running tests:\n";
my $all_pass = 1;
$all_pass &&= test_case($_->{name}, $_->{strings}, $_->{expected}) for @tests;
print "\nAll tests passed!\n" if $all_pass;
