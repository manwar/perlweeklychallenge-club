#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a valid parentheses string.

Write a script to return the string after removing the outermost parentheses of every primitive string in the primitive decomposition of the given string.
Example 1

Input: $str = "()()()"
Output: ""

Primitive Decomposition: "()" + "()" + "()"

Example 2

Input: $str = "(((())))"
Output: "((()))"

Primitive Decomposition: "(((())))"

Example 3

Input: $str = "(()())(())"
Output: "()()()"

Primitive Decomposition: "(()())" + "(())"

Example 4

Input: $str = "()((()))()"
Output: "(())"

Primitive Decomposition: "()" + "((()))" + "()"

Example 5

Input: $str = "(()(()))(()())"
Output: "()(())()()"

Primitive Decomposition: "(()(()))" + "(()())"
=cut






use Test2::V0 -no_srand => 1;
is(remove_outmost_parentheses("()()()"), "", "Example 1");
is(remove_outmost_parentheses("(((())))"), "((()))", "Example 2");
is(remove_outmost_parentheses("(()())(())"), "()()()", "Example 3");
is(remove_outmost_parentheses("()((()))()"), "(())", "Example 4");
is(remove_outmost_parentheses("(()(()))(()())"), "()(())()()", "Example 5");
done_testing();



sub remove_outmost_parentheses
{
     my $str = $_[0];
     my $re = qr/\(((?:(?R))*)\)/;
     my $output = '';
     while ( $str =~ /$re/g )
     {
          $output .= $1;
     }
     return $output;
}
