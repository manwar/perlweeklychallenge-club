#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub convert_palindrome($str) {
    my $s = $str;
    my $suffix = "";
    $suffix .= substr $s, -1, 1, "" until $s eq reverse $s;
    return $suffix . $str
}

use Test::More tests => 5 + 2;

is convert_palindrome('pinnipeds'), 'sdepinnipeds', 'Example 1';
is convert_palindrome('abcd'), 'dcbabcd', 'Example 2';
is convert_palindrome('bananas'), 'sananabananas', 'Example 3';
is convert_palindrome('dissident'), 'tnedissident', 'Example 4';
is convert_palindrome('cailliachs'), 'shcailliachs', 'Example 5';

is convert_palindrome('madam'), 'madam', 'Palindrome input';
is convert_palindrome(""), "", 'Empty string';
