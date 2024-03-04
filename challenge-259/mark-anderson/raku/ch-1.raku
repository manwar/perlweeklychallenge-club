#!/usr/bin/env raku
use Test;

is banking-day-offset('2018-06-28', 3),                               '2018-07-03';
is banking-day-offset('2018-06-28', 3, ['2018-07-03']),               '2018-07-04';
is banking-day-offset('2018-06-30', 0),                               '2018-07-02';
is banking-day-offset('2018-06-30', 8, ['2018-07-04', '2018-07-03']), '2018-07-16';
is banking-day-offset('2018-07-02', 0),                               '2018-07-02';
is banking-day-offset('2018-07-16', 4),                               '2018-07-20';

sub banking-day-offset($date is copy, $offset is copy, @holidays=[])
{
    $date .= Date;

    loop
    {
        given $date++
        {
            if all(.day-of-week ~~ 1..5, .yyyy-mm-dd !(elem) @holidays)
            {
                return .yyyy-mm-dd unless $offset--  
            }
        }
    }
}
