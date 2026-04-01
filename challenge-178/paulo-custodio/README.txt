Perl Weekly Challenge 178
https://theweeklychallenge.org/blog/perl-weekly-challenge-178/

Task 1: Quater-imaginary Base
Submitted by: Mohammad S Anwar
Write a script to convert a given number (base 10) to quater-imaginary base number and vice-versa. For more informations, please checkout wiki page.

For example,

$number_base_10 = 4
$number_quater_imaginary_base = 10300


Task 2: Business Date
Submitted by: Mohammad S Anwar
You are given $timestamp (date with time) and $duration in hours.

Write a script to find the time that occurs $duration business hours after $timestamp. For the sake of this task, let us assume the working hours is 9am to 6pm, Monday to Friday. Please ignore timezone too.

For example,

Suppose the given timestamp is 2022-08-01 10:30 and the duration is 4 hours.
Then the next business date would be 2022-08-01 14:30.

Similar if the given timestamp is 2022-08-01 17:00 and the duration is 3.5 hours.
Then the next business date would be 2022-08-02 11:30.
