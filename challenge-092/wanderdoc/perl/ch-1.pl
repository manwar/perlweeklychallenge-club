#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two strings $A and $B. Write a script to check if the given strings are Isomorphic. Print 1 if they are otherwise 0.
Example 1: Input: $A = "abc"; $B = "xyz" Output: 1
Example 2: Input: $A = "abb"; $B = "xyy" Output: 1
Example 3: Input: $A = "sum"; $B = "add" Output: 0
=cut






use Test::More;

sub is_isomorphic
{
     my ($str_1, $str_2) = @_;
     return 0 if length($str_1) != length($str_2);
     my %hash_1;

     @hash_1{split(//,$str_1)} = split(//,$str_2);


     my %hash_2 = reverse %hash_1;

     return
          scalar keys %hash_1 == scalar keys %hash_2 ? 1 : 0;
}

is_isomorphic(qw(abc xyz));

is(is_isomorphic(qw(abc xyz)), 1, 'Example 1');
is(is_isomorphic(qw(abb xyy)), 1, 'Example 2');
is(is_isomorphic(qw(sum add)), 0, 'Example 3');


done_testing();