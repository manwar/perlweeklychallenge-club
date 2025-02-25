#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.
Write a script to return the sum of Hamming distances between all the pairs of the integers in the given array of integers.
The Hamming distance between two integers is the number of places in which their binary representations differ.
Example 1

Input: @ints = (4, 14, 2)
Output: 6

Binary representation:
4  => 0100
14 => 1110
2  => 0010

HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.

Example 2

Input: @ints = (4, 14, 4)
Output: 4
=cut




use List::Util qw(max);
use Test2::V0 -no_srand => 1;

is(sum_of_distances(4, 14, 2), 6, 'Example 1');
is(sum_of_distances(4, 14, 4), 4, 'Example 2');
done_testing();






sub sum_of_distances
{
     my @arr = @_;
     my @binary = map sprintf("%b", $_), @arr;
     my $max_length = max( map length, @binary);
     @binary = map adjust_length($_, $max_length), @binary;
     my $sum = 0;
     my $iter = combinations_iterator([@binary], 2, );
     while (my $next = $iter->())
     {
          $sum += hamming_distance(@$next);
     }
     return $sum;
}

sub hamming_distance
{
     my ($str_1, $str_2) = @_;
     my $diff = $str_1 ^ $str_2;
     my $num = $diff =~ tr/\0//c;
     return $num;
}


sub adjust_length
{
     my ($str, $length) = @_;
     $str = 0 . $str while (length($str) < $length);
     return $str;
}

sub combinations_iterator 
{
     my ($aref, $k, $flag_repetitions) = @_;
     my @array = @$aref;  
     my @stack = ([[], 0]); 
     
     return sub 
     {
          while (@stack) 
          {
               my $state = pop @stack;
               my ($partial, $idx) = @$state; 

               if (@$partial == $k) 
               {
                    return $partial; 
               } 
               else 
               {
                    for my $i (reverse $idx .. $#array) 
                    {
                         if ( $flag_repetitions )
                         {
                              push @stack, [[@$partial, $array[$i]], $i];
                         }
                         else
                         {
                              push @stack, [[@$partial, $array[$i]], $i + 1];
                         }
                    }
               }
          }
          return undef;
    };
}