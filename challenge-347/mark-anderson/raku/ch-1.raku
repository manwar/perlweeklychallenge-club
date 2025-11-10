#!/usr/bin/env raku
use Test;

is format-date('1st Jan 2025'),  '2025-01-01';
is format-date('22nd Feb 2025'), '2025-02-22';
is format-date('15th Apr 2025'), '2025-04-15';
is format-date('23rd Oct 2025'), '2025-10-23';
is format-date('31st Dec 2025'), '2025-12-31';

sub format-date($str)
{
    my ($day, $month, $year) = $str.split(/<space>/);

    my %months is Map = { 
                            :Jan(1), :Feb(2),  :Mar(3),  :Apr(4),  
                            :May(5), :Jun(6),  :Jul(7),  :Aug(8), 
                            :Sep(9), :Oct(10), :Nov(11), :Dec(12)
                        }

    ($year, %months{$month}, $day.substr(0, *-2)).fmt('%02d', '-')
}
