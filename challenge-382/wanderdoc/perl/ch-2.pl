#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string that contains only 0, 1 and ? characters.

Write a script to generate all possible combinations when replacing the question marks with a zero or one.
Example 1

Input: $str = "01??0"
Output: ((0, 1, 0, 0, 0), (0, 1, 0, 1, 0), (0, 1, 1, 0, 0), (0, 1, 1, 1, 0))

Example 2

Input: $str = "101"
Output: ((1, 0, 1))

Example 3

Input: $str = "???"
Output: ((0, 0, 0), (0, 0, 1), (0, 1, 0), (0, 1, 1), (1, 0, 0), (1, 0, 1), (1, 1, 0), (1, 1, 1))

Example 4

Input: $str = "1?10"
Output: ((1, 0, 1, 0), (1, 1, 1, 0))

Example 5

Input: $str = "1?1?0"
Output: ((1, 0, 1, 0, 0), (1, 0, 1, 1, 0), (1, 1, 1, 0, 0), (1, 1, 1, 1, 0))
=cut







use Test2::V0 -no_srand => 1;
is(replace_question_mark("01??0"), '((0, 1, 0, 0, 0), (0, 1, 0, 1, 0), (0, 1, 1, 0, 0), (0, 1, 1, 1, 0))', 'Example 1');
is(replace_question_mark("101"), '((1, 0, 1))', 'Example 2');
is(replace_question_mark("???"), '((0, 0, 0), (0, 0, 1), (0, 1, 0), (0, 1, 1), (1, 0, 0), (1, 0, 1), (1, 1, 0), (1, 1, 1))', 'Example 3');
is(replace_question_mark("1?10"), '((1, 0, 1, 0), (1, 1, 1, 0))', 'Example 4');
is(replace_question_mark("1?1?0"), '((1, 0, 1, 0, 0), (1, 0, 1, 1, 0), (1, 1, 1, 0, 0), (1, 1, 1, 1, 0))', 'Example 5');
done_testing();



sub replace_question_mark
{
     my $str = $_[0];
     my @output;
     my $num_of_questions = $str =~ tr/?/?/;
     my $iterator = variations_iterator([0, 1], $num_of_questions, 1);
     while (my $variation = $iterator->()) 
     {
          my $str_copy = $str;
          my @replacement = @$variation;
          my $idx = 0;
          $str_copy =~ s/\?/$replacement[$idx++]/ge;
          $str_copy = join('', '(', join(', ', split(//, $str_copy)), ')');
          push @output, $str_copy;
     }
     return join('', '(', join(', ', @output), ')');
}

sub variations_iterator
{
     my ($aref, $k, $flag_repetition) = @_;
     my @array = @$aref;

     my @stack = ([]);  
     my @remaining = (\@array); 

     return sub 
     {
          while (@stack) 
          {
               # Get the current state
               my $partial = pop @stack; 
               my $rest = pop @remaining;
                    
               if ( @$partial == $k )
               {
                    return $partial;
               }
               else 
               {
                    for my $i ( reverse 0 .. $#$rest)
                    {
                         # New partial permutation
                         my @new_partial = (@$partial, $rest->[$i]);

                         # New remaining array excluding the current element
                         # (if no repetition):
                         my @new_rest = @$rest;
                         if ( not $flag_repetition )
                         {
                              splice(@new_rest, $i, 1);
                         }
                         push @stack, \@new_partial;
                         push @remaining, \@new_rest;
                         
                    }
               }
          }
          return undef;
     };
}
