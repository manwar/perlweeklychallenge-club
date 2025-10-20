#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two list: @source and @target.
Write a script to see if you can build the exact @target by putting these smaller lists from @source together in some order. You cannot break apart or change the order inside any of the smaller lists in @source.

Example 1
Input: @source = ([2,3], [1], [4])
       @target = (1, 2, 3, 4)
Output: true

Use in the order: [1], [2,3], [4]

Example 2

Input: @source = ([1,3], [2,4])
       @target = (1, 2, 3, 4)
Output: false

Example 3

Input: @source = ([9,1], [5,8], [2])
       @target = (5, 8, 2, 9, 1)
Output: true

Use in the order: [5,8], [2], [9,1]

Example 4

Input: @source = ([1], [3])
       @target = (1, 2, 3)
Output: false

Missing number: 2

Example 5

Input: @source = ([7,4,6])
       @target = (7, 4, 6)
Output: true

Use in the order: [7, 4, 6]
=cut





use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;
is(array_formation([[2,3], [1], [4]], [1, 2, 3, 4]), true, 'Example 1');
is(array_formation([[1,3], [2,4]], [1, 2, 3, 4]), false, 'Example 2');
is(array_formation([[9,1], [5,8], [2]], [5, 8, 2, 9, 1]), true, 'Example 3');
is(array_formation([[1], [3]], [1, 2, 3]), false, 'Example 4');
is(array_formation([[7,4,6]], [7, 4, 6]), true, 'Example 5');
done_testing();

sub array_formation
{
     my ($source, $target) = @_;
     my @source_str = map {join('', @$_)} @$source;
     my $target_str = join('', @$target);
     my $iterator = permutations_iterator(@source_str);
     while (my $permutation = $iterator->()) 
     {
          if ( join('', @$permutation) eq $target_str )
          {
               return true;
          }
     }
     return false;
}




sub permutations_iterator 
{
     my @array = @_;

     my @stack = ([]); 
     my @remaining = (\@array); 

     return sub 
     {
          while (@stack) 
          {
               # Get the current state
               my $partial = pop @stack; 
               my $rest = pop @remaining; 
                    
               if (@$rest == 0) 
               {
                    # Complete permutation
                    return $partial;
               } 
               else 
               {
                    for my $i ( reverse 0 .. $#$rest)
                    {
                         my @new_partial = (@$partial, $rest->[$i]);
                         my @new_rest = @$rest;
                         splice(@new_rest, $i, 1);
                         push @stack, \@new_partial;
                         push @remaining, \@new_rest;
                    }
               }
          }
          # If the stack is empty, we're done
          return undef;
     };
}
