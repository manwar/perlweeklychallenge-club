#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two strings containing zero or more #.
Write a script to return true if the two given strings are same by treating # as backspace.

Example 1
Input: $str1 = "ab#c"
       $str2 = "ad#c"
Output: true

For first string,  we remove "b" as it is followed by "#".
For second string, we remove "d" as it is followed by "#".
In the end both strings became the same.


Example 2

Input: $str1 = "ab##"
       $str2 = "a#b#"
Output: true


Example 3

Input: $str1 = "a#b"
       $str2 = "c"
Output: false
=cut



use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;




is(backspace_compare("ab#c", "ad#c"), true, 'Example 1');
is(backspace_compare("ab##", "a#b#"), true, 'Example 2');
is(backspace_compare("a#b", "c"), false, 'Example 3');

done_testing();

sub backspace_compare
{
     my @strings = @_; 
     for my $str ( @strings )
     {
          my $output = '';
          for my $chr ( split(//, $str) )
          {
               if ( $chr eq '#' )
               {
                    substr($output, -1) = '';
               }
               else
               {
                    $output .= $chr;
               }
          }
          $str = $output; 
     }
     return $strings[0] eq $strings[1] ? true : false;
}
