#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub reverse_string($str) {
    for my $i (0 .. (length($str) - 2) / 2) {
        my ($c1, $c2) = \(substr($str, $i, 1),
                          substr($str, length($str) - 1 - $i, 1));
        ($$c1, $$c2) = ($$c2, $$c1);
    }
    return $str
}

use Test::More tests => 5;


is reverse_string(""), "", 'Example 1';
is reverse_string('reverse the given string'), 'gnirts nevig eht esrever',
    'Example 2';
is reverse_string('Perl is Awesome'), 'emosewA si lreP', 'Example 3';
is reverse_string('v1.0.0-Beta!'), '!ateB-0.0.1v', 'Example 4';
is reverse_string('racecar'), 'racecar', 'Example 5';
