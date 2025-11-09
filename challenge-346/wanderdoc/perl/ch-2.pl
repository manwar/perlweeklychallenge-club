#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing only digits and a target integer.
Write a script to insert binary operators +, - and * between the digits in the given string that evaluates to target integer.

Example 1

Input: $str = "123", $target = 6
Output: ("1*2*3", "1+2+3")


Example 2

Input: $str = "105", $target = 5
Output: ("1*0+5", "10-5")


Example 3

Input: $str = "232", $target = 8
Output: ("2*3+2", "2+3*2")


Example 4

Input: $str = "1234", $target = 10
Output: ("1*2*3+4", "1+2+3+4")


Example 5

Input: $str = "1001", $target = 2
Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")

=cut




use List::MoreUtils qw(pairwise);
use Safe;
use Test2::V0 -no_srand => 1;




is([magic_expression(123, 6)], ["1*2*3", "1+2+3"], 'Example 1');
is([magic_expression(105, 5)], ["1*0+5", "10-5"], 'Example 2');
is([magic_expression(232, 8)], ["2*3+2", "2+3*2"], 'Example 3');
is([magic_expression(1234, 10)], ["1*2*3+4", "1+2+3+4"], 'Example 4');
is([magic_expression(1001, 2)], ["1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"], 'Example 5');
done_testing();

sub magic_expression
{
     my ($str, $target) = @_;
     my @arr = split(//, $str);
     my @output;
     my $iterator = variations_iterator(['*', '+', '-', ''], scalar(@arr) - 1, 1);
     while (my $variation = $iterator->()) 
     {
          my @var = @$variation;
          push @var, '';
          my $result_str = join('', pairwise { $a . $b } @arr, @var);
          next if $result_str =~ /(?:^|\+|\-|\*)0[0-9]/;
          # my $result = eval $result_str;
          my $compartment = Safe->new;
          $compartment->permit(qw(multiply add subtract));
          my $result = $compartment->reval($result_str);
          push @output, $result_str if $result == $target;
     }
     return @output;
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
