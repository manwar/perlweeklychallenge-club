#!/usr/bin/env perl

use v5.42;

use List::Util 'uniq';
use feature 'keyword_all';
use Test2::V0;
no warnings 'experimental::keyword_all';

sub _is_nice ($str) {
    my @letters = uniq(map lc, split //, $str);
    return all { $str =~ /$_/ and $str =~ uc($_) } @letters;
}

sub nice_string ($str) {
    my $longest_substring = '';
    for (my $i = 0; $i <= length($str); $i++) {
        for (my $j = $i; $j <= length($str); $j++) {
            my $substring = substr($str, $i, ($j - $i));
            if (_is_nice($substring) and length($substring) > length($longest_substring)) {
                $longest_substring = $substring;
            }
        }
    }
    return $longest_substring;
}

is nice_string('YaaAho'), 'aaA', 'Example 1';
is nice_string('cC'), 'cC', 'Example 2';
is nice_string('A'), '', 'Example 3';

done_testing;
