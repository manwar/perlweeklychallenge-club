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
    my %h is Map = False => { 
                                6 => 260, 
                                7 => 260,
                                1 => 261,
                                2 => 261,
                                3 => 261,
                                4 => 261,
                                5 => 261 
                            },
                   True  => {
                                6 => 260,
                                5 => 261,
                                7 => 261,
                                1 => 262,
                                2 => 262,      
                                3 => 262,      
                                4 => 262      
                            }

    my $dt = Date.new($year, 1, 1);

    %h{ $dt.is-leap-year }{ $dt.day-of-week }
}
