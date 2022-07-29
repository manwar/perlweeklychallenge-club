#!/usr/bin/env raku

sub MAIN(
  Int $year = DateTime.now.year #= the year to check
) {
  (1 .. 12)
    .map: {
      Date.new: :$year, month => $_ andthen
        .last-date-in-month andthen
        .earlier: day => .day-of-week % 7
    } andthen
    .map: *.Str andthen
    .join: "\n" andthen
    .say;
}