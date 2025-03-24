#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub equal_strings($s1, $s2, $s3) {
    my $pos = -1;
    ++$pos while substr($s1, $pos + 1, 1) eq substr($s2, $pos + 1, 1)
              && substr($s1, $pos + 1, 1) eq substr($s3, $pos + 1, 1);
    return -1 if -1 == $pos;

    my $delete = 0;
    $delete -= 1 + $pos - length for $s1, $s2, $s3;
    return $delete
}
use Test::More tests => 3 + 1;

is equal_strings('abc', 'abb', 'ab'), 2, 'Example 1';
is equal_strings('ayz', 'cyz', 'xyz'), -1, 'Example 2';
is equal_strings('yza', 'yzb', 'yzc'), 3, 'Example 3';
is equal_strings('abcdefgh', 'abcdexxxx', 'abcdexx'), 9, 'longer';
