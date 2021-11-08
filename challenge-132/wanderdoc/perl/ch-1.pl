#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a date (yyyy/mm/dd).

Assuming, the given date is your date of birth. Write a script to find the mirror dates of the given date.

Dave Cross has built cool site that does something similar.
Assuming today is 2021/09/22.
Example 1:

Input: 2021/09/18
Output: 2021/09/14, 2021/09/26

On the date you were born, someone who was your current age, would have been born on 2021/09/14.
Someone born today will be your current age on 2021/09/26.

Example 2:
Input: 1975/10/10
Output: 1929/10/27, 2067/09/05

On the date you were born, someone who was your current age, would have been born on 1929/10/27.
Someone born today will be your current age on 2067/09/05.

Example 3:

Input: 1967/02/14
Output: 1912/07/08, 2076/04/30

On the date you were born, someone who was your current age, would have been born on 1912/07/08.
Someone born today will be your current age on 2076/04/30.

=cut





use Time::Piece;
use Time::Seconds;



my $FORMAT = '%Y/%m/%d';



sub create_mirror_dates
{
     my $date = Time::Piece->strptime($_[0], $FORMAT);
     my $today = Time::Piece->strptime('2021/09/22', $FORMAT); # or localtime
     my $difference = $today - $date; # seconds
     my $first = $date - $difference;
     my $second = $today + $difference;
     return $first->ymd('/'), $second->ymd('/'); 

}

print join(" ", create_mirror_dates('2021/09/18')), $/;
print join(" ", create_mirror_dates('1975/10/10')), $/;
print join(" ", create_mirror_dates('1967/02/14')), $/;