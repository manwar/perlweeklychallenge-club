#!/bin/env raku

unit sub MAIN(UInt:D $year where 1753 ≤ * ≤ 9999);

put (1..12).grep({ Date("$year-{ .fmt('%02d') }-13").day-of-week == 5 }).elems;
