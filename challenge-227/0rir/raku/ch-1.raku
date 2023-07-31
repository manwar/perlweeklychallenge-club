#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
227-1: Friday 13th          Submitted by: Peter Campbell Smith

Given a year number in the range 1753 to 9999, find how many dates in the
year are Friday 13th, assume that the current Gregorian calendar applies.

Example
Input: $year = 2023
Output: 2

Since there are only 2 Friday 13th in the given year 2023 i.e. 13th Jan and 13th Oct.

=end comment

sub fri13ths-in-year( $year -->Int) {
    my $ret;
    for 1..12 -> $mo {
       ++ $ret if Date.new( $year, $mo, 13).day-of-week == 5;
    }
    $ret;
}

my $year = 2026;
say "Input: \$year = $year\n Output: ", fri13ths-in-year( $year);

