#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to find all the years between 1900 and 2100 which is a Long Year. A year is Long if it has 53 weeks.

Expected Output

1903, 1908, 1914, 1920, 1925, 1931, 1936, 1942, 1948, 1953, 1959, 1964, 1970, 1976, 1981, 1987, 1992, 1998, 2004, 2009, 2015, 2020, 2026, 2032, 2037, 2043, 2048, 2054, 2060, 2065, 2071, 2076, 2082, 2088, 2093, 2099
=cut







use Time::Piece;

my @expected = (1903, 1908, 1914, 1920, 1925, 1931, 1936, 1942, 1948, 1953, 1959, 1964, 1970, 1976, 1981, 1987, 1992, 1998, 2004, 2009, 2015, 2020, 2026, 2032, 2037, 2043, 2048, 2054, 2060, 2065, 2071, 2076, 2082, 2088, 2093, 2099);
my %exp;
@exp{@expected} = ();



for my $year ( 1900 .. 2100 )
{
     my $last_day_of_year = Time::Piece->strptime("${year}-12-31", "%Y-%m-%d");
     if ( 53 == $last_day_of_year->week )
     {
          print $year, $/;
          warn "Year missed: $year.$/" if not exists $exp{$year};
          delete $exp{$year};
     }
}
warn "Year $_ was not discovered.$/" for keys %exp;