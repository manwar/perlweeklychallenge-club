#!/usr/bin/env raku

=begin head1

Week 184:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-184

Task #1: Sequence Number

    You are given list of strings in the format aa9999 i.e. first 2
    characters can be anything 'a-z' followed by 4 digits '0-9'.

    Write a script to replace the first two characters with sequence
    starting with '00', '01', '02' etc.

=end head1

use v6;
use Test;

is-deeply sequence-number('ab1234', 'cd5678', 'ef1342'),
   ('001234', '015678', '021342'), 'Example 1';

is-deeply sequence-number('pq1122', 'rs3334'),
   ('001122', '013334'), 'Example 2';

done-testing;

sub sequence-number(+@list) {
    my $seq = 0;
    @list.map: { S/ ^ <:L>**2 /{ sprintf '%02d', $seq++ }/ }
}

