#!/usr/bin/perl
# task2.pl
#

use warnings;
use strict;
use Data::Dumper;
use FindBin qw($Bin);
use lib "$Bin/lib";

my @s = ("adc", "wzy", "abc");
find_odd(@s);
@s = ("aaa", "bob", "ccc", "ddd");
find_odd(@s);

# Given an array of strings, let's find the odd one
sub find_odd {
    my @s = @_;
    my $len = length($s[0]);
    my $result;
    foreach my $string (@s) {
        # Just making sure all input strings share the same length
        die "Not all strings are of the same length!\n" if length($string) != $len;
        my @chars = split //,$string;
        my @diffs = ();
        # As long as we have at least two characters left, remove the first and
        # calculate the difference of the second and the first
        # Push the result onto another array
        while(scalar(@chars) > 1) {
            my $c = shift @chars;
            # Yes, ord() is shifted by 97 as opposed to 0->a, ..., but since
            # this affects both parts of the difference, that amounts to
            # zero difference.
            push @diffs, (ord($chars[0]) - ord($c));
        }
        # Build a hash key from the diffs and push the original string
        # onto an array which is in the result hash for the calculated key
        # This way the odd string will be the only string in its array,
        # while the other strings share they key, filling up the corresponding
        # array with multiple values
        my $key = join(",", @diffs);
        push @{$result->{$key}}, $string;
    }
    foreach my $k (keys %$result) {
        # The array with only one element contains the odd string
        print "Odd string $result->{$k}->[0]!\n" if scalar(@{$result->{$k}}) == 1;
    }
}
