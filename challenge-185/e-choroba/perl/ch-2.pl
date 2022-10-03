#! /usr/bin/perl
use warnings;
use strict;
use experimental qw{ signatures };

sub mask_code (@codes) {
    for my $code (@codes) {
        my $count = 0;
        $code =~ s/[a-z0-9]/++$count <= 4 ? 'x' : $&/peg;
    }
    return \@codes
}

use Test2::V0;
plan 3;

is mask_code('ab-cde-123', '123.abc.420', '3abc-0010.xy'),
    ['xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy'],
    'Example 1';

is mask_code('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f'),
    ['xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f'],
    'Example 2';

is mask_code('abc'),
    ['xxx'],
    'Shorter';
