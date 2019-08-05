#!/bin/env perl6

for 1900..2019 -> $year {
    for 1,3,5,7,8,10,12 -> $month {
        if Date.new($year, $month, 1).day-of-week == 5 {
            say sprintf('%d-%02d has 5 weekends', $year, $month);
        }
    }
}
