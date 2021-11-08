#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a number $N >= 10. Write a script to split the given number such that the difference between two consecutive numbers is always 1 and it shouldn’t have leading 0.
Print the given number if it impossible to split the number.

Example Input: $N = 1234 Output: 1,2,3,4
Input: $N = 91011 Output: 9,10,11
Input: $N = 10203 Output: 10203 as it is impossible to split satisfying the conditions.
=cut






sub find_sequence
{
     my $int = $_[0];
     my $length = length($int);
     for my $i ( 1 .. $length / 2 )
     {
          my $copy = $int;

          my @numbers;
          $numbers[0] = substr($copy, 0, $i);
          $copy = substr($copy, $i);
          for my $j ( $i .. $i + 1 )
          {
               while ( substr($copy, 0, $j) - 1 == $numbers[-1] and substr($copy, 0, 1) != 0 )
               {
                    push @numbers, substr($copy, 0, $j);
                    $copy = substr($copy, $j);
                    return join(",",@numbers) unless length($copy);
               }
          }


     }
     return $int;
}


print find_sequence($_), $/ for (12345, 91011, 10203, 100101102, 9899100102);