#! /usr/bin/env raku

unit sub MAIN (Int $year where 1753 <= $year <= 9999 = Date.today.year);

say (1 .. 12).grep({Date.new(year => $year, month => $_, day => 13).day-of-week == 5 }).elems;
