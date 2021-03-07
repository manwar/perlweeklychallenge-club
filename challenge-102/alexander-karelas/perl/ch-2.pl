#!/usr/bin/env perl

use v5.30;
use warnings;

use Test::More;

sub create_string {
    my ($n) = @_;

    my $ret = '-' x $n;
    my $pos = $n - 1;
    while ($pos >= 0) {
        substr($ret, $pos, 1, '#');
        my $number = $pos + 1;
        $pos -= length($number);
        if ($pos >= 0) {
            substr($ret, $pos, length($number), $number);
        }
        $pos--;
    }

    return $ret;
}

is create_string(1), '#', 'length 1';
is create_string(2), '2#', 'length 2';
is create_string(3), '#3#', 'length 3';
is create_string(10), '#3#5#7#10#', 'length 10';
is create_string(14), '2#4#6#8#11#14#', 'length 14';

done_testing;