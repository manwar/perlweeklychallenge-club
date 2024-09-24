#!/usr/bin/perl

use v5.40;

use Test::More tests => 4;

sub is_palindrome {
    my $l = length $_[0] / 2;
    return ($l == 0
            or substr($_[0], 0, $l) eq scalar reverse substr($_[0], -$l));
}

sub get_closest_palindrome {
    my ($l, $h) = ($_[0] - 1, $_[0] + 1);
    --$l until is_palindrome($l);
    ++$h until is_palindrome($h);
    return $h - $_[0] < $_[0] - $l ? $h : $l;
}

is(get_closest_palindrome(123),  121);
is(get_closest_palindrome(2),    1);
is(get_closest_palindrome(1400), 1441);
is(get_closest_palindrome(1001), 999);
