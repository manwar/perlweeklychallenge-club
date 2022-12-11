#! /usr/bin/env raku

subset MissingTime where /^<[012\?]><[0..9\?]>\:<[0..5\?]><[0..9\?]>$/;

unit sub MAIN (MissingTime $time where $time.comb.Bag<?> == 1);

die "Illegal time" if $time.substr(0,1) eq "2" && $time.substr(1,1) ne any <0 1 2 3 ?>;

given $time
{
  when .substr(0,1) eq "?" && .substr(1,1) < 4 { say "2"; } # "?[0..3]:**"
  when .substr(0,1) eq "?"                     { say "1"; } # "?[4..9]:**"
  when .substr(1,1) eq "?" && .substr(0,1) < 2 { say "9"; } # "[0..1]?:**"
  when .substr(1,1) eq "?"                     { say "3"; } # "2?:**"
  when .substr(3,1) eq "?"                     { say "5"; } # "**:?*"
  when .substr(4,1) eq "?"                     { say "9"; } # "**:*?"
}
