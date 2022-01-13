sub working-days-in-year ( Int $year --> Int ) {
    enum Days-of-the-week «:Monday(1) Tuesday Wednesday Thursday Friday Saturday Sunday»;
    constant $workdays = Monday .. Friday;

    sub is-workday         ( Date $d    --> Bool  ) { $d.day-of-week ~~ $workdays }
    sub first-day-of-year  ( Int  $year --> Date  ) { Date.new: :$year }
    sub all-days-in-year   ( Int  $year --> Range ) { first-day-of-year($year  ) ..^
                                                      first-day-of-year($year+1)     }

    return +grep &is-workday, all-days-in-year($year);
}

use Test;
my @tests =
    2021 => 261,
    2020 => 262,
;
plan +@tests;

for @tests -> ( :key($input), :value($expected) ) {
    is working-days-in-year($input), $expected,
      "working-days-in-year($input) == $expected";
}

