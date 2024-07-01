#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub replace_digits($str) {
    my $result = "";
    my $letter;
    for my $char (split //, $str) {
        if ($char =~ /[0-9]/) {
            return "" unless $letter;

            my $ord = $char + ord $letter;
            return "" if $ord > ord 'z';

            $result .= chr $ord;
        } else {
            $result .= $letter = $char;
        }
    }
    return $result
}

use Test::More tests => 4 + 3;

is replace_digits('a1c1e1'), 'abcdef', 'Example 1';
is replace_digits('a1b2c3d4'), 'abbdcfdh', 'Example 2';
is replace_digits('b2b'), 'bdb', 'Example 3';
is replace_digits('a16z'), 'abgz', 'Example 4';

is replace_digits('a00b'), 'aaab', 'Zero';
is replace_digits('1a'), "", 'Start with a digit';
is replace_digits('z01'), "", 'Overflow';
