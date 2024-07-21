#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a word, $word and a character, $char.

Write a script to replace the substring up to and including $char with its characters sorted alphabetically. If the $char doesn't exist then DON'T do anything.
Example 1

Input: $str = "challenge", $char = "e"
Output: "acehllnge"

Example 2

Input: $str = "programming", $char = "a"
Output: "agoprrmming"

Example 3

Input: $str = "champion", $char = "b"
Output: "champion"
=cut



use List::MoreUtils qw(first_index);
use Test2::V0;

is(reverse_word("challenge", "e"), "acehllnge", 'Example 1');
is(reverse_word("programming", "a"), "agoprrmming", 'Example 2');
is(reverse_word("champion", "b"), "champion", 'Example 3');
done_testing();

sub reverse_word
{
     my $word = $_[0];
     my $char = $_[1];
     my @arr = split(//, $word);
     my $idx = first_index { $_ eq $char } @arr;
     if ( $idx == -1 )
     {
          return $word;
     }
     else
     {
          @arr[0 .. $idx] = sort {$a cmp $b} @arr[0 .. $idx];
          return join('', @arr);
     }
}