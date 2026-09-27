#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.

Write a script to convert the given string to palindrome by adding characters in front of it.
Example 1

Input: $str = "pinnipeds"
Output: "sdepinnipeds"

Example 2

Input: $str = "abcd"
Output: "dcbabcd"

Example 3

Input: $str = "bananas"
Output: "sananabananas"

Example 4

Input: $str = "dissident"
Output: "tnedissident"

Example 5

Input: $str = "cailliachs"
Output: "shcailliachs"
=cut







use Test2::V0 -no_srand => 1;

is(create_palindrome('pinnipeds'), 'sdepinnipeds', 'Example 1');
is(create_palindrome('abcd'), 'dcbabcd', 'Example 2');
is(create_palindrome('bananas'), 'sananabananas', 'Example 3');
is(create_palindrome('dissident'), 'tnedissident', 'Example 4');
is(create_palindrome('cailliachs'), 'shcailliachs', 'Example 5');
done_testing();


sub create_palindrome
{
     my $str = $_[0];
     if ( is_palindrome($str))
     {
          return $str;
     }

     for my $idx ( 1 .. length($str) )
     {
          my $prefix = reverse(substr($str, -$idx));
          my $this_str = $prefix . $str;
          if ( is_palindrome($this_str) )
          {
               return $this_str;
          }
     }
     die "Something got wrong."; # if I am here.
}

sub is_palindrome
{
     my $str = $_[0];
     return $str eq reverse($str);
}
