#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
There are $n balls of mixed colors: red, blue or green. They are all distributed in 10 boxes labelled 0-9.

You are given a string describing the location of balls.

Write a script to find the number of boxes containing all three colors. Return -1 if none found.
Example 1

Input: $str = "G0B1R2R0B0"
Output: 1

The given string describes there are 5 balls as below:
Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
Box 1: Blue(B1) => 1 ball
Box 2: Red(R2) => 1 ball

Example 2

Input: $str = "G1R3R6B3G6B1B6R1G3"
Output: 3

The given string describes there are 5 balls as below:
Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls

Example 3

Input: $str = "B3B2G1B3"
Output: -1

Box 1: Green(G1) => 1 ball
Box 2: Blue(B2)  => 1 ball
Box 3: Blue(B3)  => 2 balls
=cut

use Test2::V0 -no_srand => 1;
is(balls_and_boxes('G0B1R2R0B0'), 1, 'Example 1');
is(balls_and_boxes('G1R3R6B3G6B1B6R1G3'), 3, 'Example 2');
is(balls_and_boxes('B3B2G1B3'), -1, 'Example 3');
done_testing();

sub balls_and_boxes
{
     my $str = $_[0];
     my %data;
     while ( $str =~ /([RGB])([0-9])/g )
     {
          $data{$2}{$1}++;
     }
     my $output = 
          scalar grep { scalar keys %{$data{$_}} == 3 } 
          keys %data;
     return $output > 0 ? $output : -1;
}
