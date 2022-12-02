#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

    https://theweeklychallenge.org/blog/perl-weekly-challenge-193

    Task 2: Odd String
    Submitted by: Mohammad S Anwar
    You are given a list of strings of same length, @s.

    Write a script to find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.

    Find the difference array for each string as shown in the example. Then pick the odd one out.

=cut

is(oddString("adc", "wzy", "abc"), "abc", 'Example 1');
is(oddString("aaa", "bob", "ccc", "ddd"), "bob", 'Example 2');

sub oddString {
    my (@strings_list) = @_;

    my %strings_list_diff_hash = ();

    foreach my $string (@strings_list) {
        my $diff = join(',', map {
            ord(substr($string, $_ + 1, 1)) - ord(substr($string, $_, 1))
        } (0..length($string) - 2));

        push(@{$strings_list_diff_hash{$diff}}, $string)
    }

    foreach my $diff (keys(%strings_list_diff_hash)) {
        if (scalar(@{$strings_list_diff_hash{$diff}}) == 1) {
            return($strings_list_diff_hash{$diff}[0]);
        }
    }
}

done_testing()
