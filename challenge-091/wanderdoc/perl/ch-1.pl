#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive number $N. Write a script to count number and display as you read it.
Example 1: Input: $N = 1122234 Output: 21321314 as we read "two 1 three 2 one 3 one 4"
Example 2: Input: $N = 2333445 Output: 12332415 as we read "one 2 three 3 two 4 one 5"
Example 3: Input: $N = 12345 Output: 1112131415 as we read "one 1 one 2 one 3 one 4 one 5"
=cut




use Test::More;




sub count_number
{
     my $num = $_[0];
     my @arr = split(//, $num);

     my @data;

     do { ( scalar @data == 0 or $_ != $data[-1][0] ) ? 
             push @data, [$_, 1] : $data[-1][1]++ }
          for @arr;
     my $output = join('',map { reverse @$_ } @data);
     return $output;
}


is(count_number(1122234), 21321314, 'Example 1');
is(count_number(2333445), 12332415, 'Example 2');
is(count_number(12345), 1112131415, 'Example 3');



done_testing();