#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list (3 or more) of positive integers, @ints.

Write a script to return all even 3-digits integers that can be formed using the integers in the given list.
Example 1

Input: @ints = (2, 1, 3, 0)
Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)

Example 2

Input: @ints = (2, 2, 8, 8, 2)
Output: (222, 228, 282, 288, 822, 828, 882)
=cut


use Test2::V0 -no_srand => 1;

is( find_even(2, 1, 3, 0), [102, 120, 130, 132, 210, 230, 302, 310, 312, 320], 'Example 1');
is( find_even(2, 2, 8, 8, 2), [222, 228, 282, 288, 822, 828, 882], 'Example 2');
done_testing();

sub find_even 
{
     my @arr = sort { $a <=> $b } @_;
     my @output;
     my %seen;

     my @stack = ( [ [], \@arr ] );

     while (@stack) 
     {
          my ($current, $remaining) = @{ pop @stack };
          if (@$current == 3) 
          {
               my $number = join('', @$current);
               if ($current->[2] % 2 == 0 and $current->[0] != 0 and !$seen{$number}) 
               {
                    push @output, $number;
                    $seen{$number} = 1;
               }
               next;
          }
          for my $i (reverse 0 .. $#$remaining) 
          {
               my @new_current = (@$current, $remaining->[$i]);
               my @new_remaining = @$remaining;
               splice(@new_remaining, $i, 1); # Remove the used digit
               push @stack, [ \@new_current, \@new_remaining ];
          }
     }
     return \@output;
}