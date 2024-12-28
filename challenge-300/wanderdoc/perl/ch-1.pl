#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer, $int.

Write a script to return the number of beautiful arrangements that you can construct.

A permutation of n integers, 1-indexed, is considered a beautiful arrangement
if for every i (1 <= i <= n) either of the following is true:

1) perm[i] is divisible by i
2) i is divisible by perm[i]

Example 1

Input: $n = 2
Output: 2

1st arrangement: [1, 2]
    perm[1] is divisible by i = 1
    perm[2] is divisible by i = 2
2nd arrangement: [2, 1]
    perm[1] is divisible by i = 1
    i=2 is divisible by perm[2] = 1

Example 2

Input: $n = 1
Output: 1

Example 3

Input: $n = 10
Output: 700
=cut



use Test2::V0 -no_srand => 1;

is(count_beautiful_arrangements(2), 2, 'Example 1');
is(count_beautiful_arrangements(1), 1, 'Example 2');
is(count_beautiful_arrangements(10), 700, 'Example 3');
done_testing();

sub count_beautiful_arrangements
{
     my $n = $_[0];
     my @data = 1 .. $n;

     my $iter = beautiful_arrangements_iterator(@data); ;
     my $counter = 0; 
     while (my $aref = $iter->())   
     {
          $counter++;
     }
     return $counter;
} 

sub beautiful_arrangements_iterator 
{
     my @array = @_; # (1 .. $n);
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
                    return $partial; 
               } 
               else 
               {
                    for my $i (reverse 0 .. $#$rest) 
                    {
                         # Check for beautiful arrangement.
                         if ($rest->[$i] % (@$partial + 1) != 0 
                              and (@$partial + 1) % $rest->[$i] != 0) 
                              {
                                   next;  # Skip if not. 
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