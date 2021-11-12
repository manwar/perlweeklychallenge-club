sub is-long ( Int $year --> Bool ) {
    return Date.new("$year-12-31").week-number == 53;
}

use Test; plan 1;
my @expected =
    1903, 1908, 1914, 1920, 1925,
    1931, 1936, 1942, 1948, 1953,
    1959, 1964, 1970, 1976, 1981,
    1987, 1992, 1998, 2004, 2009,
    2015, 2020, 2026, 2032, 2037,
    2043, 2048, 2054, 2060, 2065,
    2071, 2076, 2082, 2088, 2093,
    2099
;

my @got = grep &is-long, 1900 .. 2100;
is-deeply @got, @expected;
