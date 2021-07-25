#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a stream of numbers, @N. Write a script to print the average of the stream at every point.
Example
Input: @N = (10, 20, 30, 40, 50, 60, 70, 80, 90, ...)
Output:      10, 15, 20, 25, 30, 35, 40, 45, 50, ...
=cut








use feature 'state';

sub stream_avg
{
     my $num = $_[0];
     state $sum = 0;
     state $count = 0;

     $sum += $num;
     $count++;
     return $sum / $count;
}

for my $number (map $_ * 10, 1 .. 10)
{
     print join("\t", $number, stream_avg($number)), $/;
}