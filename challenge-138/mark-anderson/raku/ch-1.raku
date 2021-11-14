#!/usr/bin/env raku

use Test;
plan 9;

is workdays(2020), 262;
is workdays(2021), 261;
is workdays(2022), 260;
is workdays(2050), 260;
is workdays(2051), 260;
is workdays(2052), 262;
is workdays(2053), 261;
is workdays(2075), 261;
is workdays(2076), 262;

sub workdays($year)
{
    my $a := [ Nil, 261, 261, 261, 261, 261, 260, 260 ],
             [ Nil, 262, 262, 262, 262, 261, 260, 261 ];

    my $dt := Date.new($year, 1, 1);
    $a[ +$dt.is-leap-year ][ $dt.day-of-week ];
}
