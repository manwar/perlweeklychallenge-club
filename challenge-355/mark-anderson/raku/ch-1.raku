#!/usr/bin/env raku
use Test;

is thousand-separator(1),          '1';
is thousand-separator(12),         '12';
is thousand-separator(123),        '123';
is thousand-separator(1234),       '1,234';
is thousand-separator(12345),      '12,345';
is thousand-separator(123456),     '123,456';
is thousand-separator(1234567),    '1,234,567';
is thousand-separator(12345678),   '12,345,678';
is thousand-separator(123456789),  '123,456,789';
is thousand-separator(1234567890), '1,234,567,890';

sub thousand-separator($n)
{
    ($n ~~ /^ (\d ** 1..3) (\d ** 3)* $/).flat.join(',')
}
