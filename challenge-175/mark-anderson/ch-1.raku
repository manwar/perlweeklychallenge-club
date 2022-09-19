#!/usr/bin/env raku

use lib 'lib';
use Date::WDOM;

for 1..12 -> $month
{
    say Date::WDOM.new(weekday-of-month => 'Last', 
                       day-of-week      =>  7, 
                       month            =>  $month, 
                       year             =>  2022).yyyy-mm-dd
}
