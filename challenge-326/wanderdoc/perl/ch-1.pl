#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a date in the format YYYY-MM-DD.
Write a script to find day number of the year that the given date represent.

Example 1

Input: $date = '2025-02-02'
Output: 33

The 2nd Feb, 2025 is the 33rd day of the year.


Example 2

Input: $date = '2025-04-10'
Output: 100


Example 3

Input: $date = '2025-09-07'
Output: 250

=cut



use Time::Piece;
use Test2::V0 -no_srand => 1;
is(str_to_day_of_year('2025-02-02'), 33, 'Example 1');
is(str_to_day_of_year('2025-04-10'), 100, 'Example 2');
is(str_to_day_of_year('2025-09-07'), 250, 'Example 3');
done_testing();

sub str_to_day_of_year
{
     my $string = $_[0];
     my $format = '%Y-%m-%d';
     my $dt = Time::Piece->strptime($string, $format);
     return $dt->day_of_year + 1; # $dt->day_of_year: 0 = Jan 01
}
