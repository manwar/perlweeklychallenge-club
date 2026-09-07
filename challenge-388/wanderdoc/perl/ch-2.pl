#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
A company with $n employees is running a Secret Santa exchange. Each employee buys one gift and receives one gift.

Write a script to return the total number of valid gift assignments where no employee receives the gift they originally bought (i.e., employee $i must not be assigned gift $i).
Example 1

Input: $n = 1
Output: 0

Only 1 participant exists. They would have to receive their own gift, which is invalid.

Example 2

Input: $n = 2
Output: 1

Participants 1 and 2 must swap gifts ([2, 1]).

Example 3

Input: $n = 3
Output: 2

The 2 valid gift arrays where array[i] is who person i+1 receives from:
[2, 3, 1]
[3, 1, 2]

Example 4

Input: $n = 4
Output: 9

The 9 valid arrays are:
[2, 1, 4, 3], [2, 3, 4, 1], [2, 4, 1, 3],
[3, 1, 4, 2], [3, 4, 1, 2], [3, 4, 2, 1],
[4, 1, 2, 3], [4, 3, 1, 2], [4, 3, 2, 1],

Example 5

Input: $n = 5
Output: 44

There are 44 valid permutations out of 5! = 120 total possible arrangements.
=cut


use Test2::V0 -no_srand => 1;

is(list_derangements(1), 0, 'Example 2');
is(list_derangements(2), 1, 'Example 2');
is(list_derangements(3), 2, 'Example 3');
is(list_derangements(4), 9, 'Example 4');
is(list_derangements(5), 44, 'Example 5');
done_testing();

sub list_derangements
{
     my $n = $_[0];
     my $iterator = derangements_iterator(1..$n);
     my $counter = 0;
     $counter++ while (my $iter = $iterator->());
     return $counter;
}


sub derangements_iterator 
{
     my @array = @_;

     my @stack = ([]);  
     my @remaining = (\@array); 

     return sub 
     {
          while (@stack) 
          {
               my $partial = pop @stack; 
               my $rest = pop @remaining; 
               
               if (@$rest == 0) 
               {
                    return $partial;  # Already validated at this point
               } 
               else 
               {
                    for my $i (reverse 0 .. $#$rest) 
                    {
                         # Check if adding this element would keep it in its original position
                         if ($rest->[$i] eq $array[@$partial]) 
                         {
                              next;  # Skip 
                         }

                    my @new_partial = (@$partial, $rest->[$i]);
                    my @new_rest = @$rest;
                    splice(@new_rest, $i, 1);
                    push @stack, \@new_partial;
                    push @remaining, \@new_rest;
                }
            }
        }
        return undef;
    };
}
