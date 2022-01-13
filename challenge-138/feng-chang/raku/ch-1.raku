#!/bin/env raku

sub MAIN(UInt:D $year where 1000 ≤ * ≤ 9999) {
    put ("$year-01-01".Date .. "$year-12-31".Date)».day-of-week.grep(0 < * < 6).elems;
}
