#!/usr/bin/env perl6

enum Months «
  :Jan(1) Feb Mar
   Apr    May Jun
   Jul    Aug Sep
   Oct    Nov Dec
»;

"$_.key(): $_.value()".say for (gather {
  given Date.new(:2019year) {
    take Months(.month) if .day-of-week ≠ 6|7;
    &?BLOCK(.succ) if .succ.year == .year;
  }
}).Bag.pairs.sort({ ::{$^a.key} <=> ::{$^b.key} });
