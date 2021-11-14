#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a year, $year in 4-digits form. Write a script to calculate the total number of workdays in the given year.
For the task, we consider, Monday - Friday as workdays.
Example 1 Input: $year = 2021 Output: 261
Example 2 Input: $year = 2020 Output: 262
=cut








use Time::Piece;
use Time::Seconds;
use Test::More;





sub workdays
{
     my $year = $_[0];
     my $workdays;
     my $day = Time::Piece->strptime("${year}0101", "%Y%m%D");
     while ( $day->year == $year )
     {
          $workdays++ unless ( $day->wday == 1 or $day->wday == 7 );
          $day += ONE_DAY;
     }
     return $workdays;
}


is(workdays(2020), 262, 'Test 2020');
is(workdays(2021), 261, 'Test 2021');
done_testing();