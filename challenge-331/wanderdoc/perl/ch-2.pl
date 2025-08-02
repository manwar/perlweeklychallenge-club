#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two strings, source and target.
Write a script to find out if the given strings are Buddy Strings.
If swapping of a letter in one string make them same as the other then they are `Buddy Strings`.
Example 1
Input: $source = "fuck"
       $target = "fcuk"
Output: true

The swapping of 'u' with 'c' makes it buddy strings.


Example 2

Input: $source = "love"
       $target = "love"
Output: false


Example 3

Input: $source = "fodo"
       $target = "food"
Output: true


Example 4

Input: $source = "feed"
       $target = "feed"
Output: true
=cut

# use feature 'state';


use List::Util qw(first);
use constant { true => 1, false => 0 };

use Test2::V0 -no_srand => 1;

is(buddy_strings("fuck", "fcuk"), true, 'Example 1');
is(buddy_strings("love", "love"), false, 'Example 2');
is(buddy_strings("fodo", "food"), true, 'Example 3');
is(buddy_strings("feed", "feed"), true, 'Example 4');
done_testing();

sub buddy_strings
{
     my ($str_1, $str_2) = @_;
     if ( length($str_1) != length($str_2) )
     {
          return false;
     }
     my (%ltr_1, %ltr_2);
     $ltr_1{$_}++ for split(//, $str_1);
     $ltr_2{$_}++ for split(//, $str_2);
     my @standard = sort {$a cmp $b} keys %ltr_1;
     if ( join('', @standard) ne join('', sort {$a cmp $b} keys %ltr_2) )
     {
          return false;
     }
     if ( join('-', @ltr_1{@standard}) ne join('-', @ltr_2{@standard}) )
     {
          return false;
     }
     if ( $str_1 eq $str_2)
     {
          if ( defined first { $_ > 1 } values %ltr_1 )
          {
               return true;
          }
          else
          {
               return false;
          }
     }
     return true;
}
