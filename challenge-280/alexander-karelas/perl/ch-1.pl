#!/usr/bin/env perl

use v5.40;

use Test::More;

sub do_it ($str) {
    my $reverse_str = reverse $str;
    my ($letter) = $reverse_str =~ /.*(.).*?\1/;
    return $letter;
}

is do_it('acbddbca'), 'd', 'Example 1';
is do_it('abccd'), 'c', 'Example 2';
is do_it('abcdabbb'), 'a', 'Example 3';

done_testing;
