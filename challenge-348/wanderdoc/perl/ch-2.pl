#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two strings, $source and $target, containing time in 24-hour time form.
Write a script to convert the source into target by performing one of the following operations:

1. Add  1 minute
2. Add  5 minutes
3. Add 15 minutes
4. Add 60 minutes

Find the total operations needed to get to the target.

Example 1
Input: $source = "02:30"
       $target = "02:45"
Output: 1

Just one operation i.e. "Add 15 minutes".


Example 2

Input: $source = "11:55"
       $target = "12:15"
Output: 2

Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".

Example 3

Input: $source = "09:00"
       $target = "13:00"
Output: 4

Four operations of "Add 60 minutes".


Example 4

Input: $source = "23:45"
       $target = "00:30"
Output: 3

Three operations of "Add 15 minutes".


Example 5

Input: $source = "14:20"
       $target = "15:25"
Output: 2

Two operations, one "Add 60 minutes" and one "Add 5 minutes"
=cut

use Time::Piece;
use Time::Seconds;
use Test2::V0 -no_srand => 1;


is(convert_time("02:30", "02:45"), 1, 'Example 1');
is(convert_time("11:55", "12:15"), 2, 'Example 2');
is(convert_time("09:00", "13:00"), 4, 'Example 3');
is(convert_time("23:45", "00:30"), 3, 'Example 4');
is(convert_time("14:20", "15:25"), 2, 'Example 5');
done_testing();

sub convert_time
{
     my ($source, $target) = @_;
     my $dummy_date = '20250101';
     my @hours = map { (split(/:/))[0] } ($source, $target);
     $source = Time::Piece->strptime(join(' ', $dummy_date, $source), '%Y%m%d %H:%M');
     $target = Time::Piece->strptime(join(' ', $dummy_date, $target), '%Y%m%d %H:%M');
     if ( $hours[1] < $hours[0] )
     {
          $target += ONE_DAY;
     }

     my $steps = 0;
     my @operations = map { ONE_MINUTE * $_ } (60, 15, 5, 1);

     my $diff = $target - $source;

     OUTER: for my $op ( @operations )
     {
          while ( $diff >= $op )
          {
               $source += $op; 
               $steps++;
               last OUTER if ($source == $target);
               $diff = $target - $source; 
          }
     }
     return $steps;
}
