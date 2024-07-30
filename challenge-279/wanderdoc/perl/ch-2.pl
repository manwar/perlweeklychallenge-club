#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str.

Write a script to split the given string into two containing exactly same number of vowels and return true if you can otherwise false.
Example 1

Input: $str = "perl"
Output: false

Example 2

Input: $str = "book"
Output: true

Two possible strings "bo" and "ok" containing exactly one vowel each.

Example 3

Input: $str = "goodmorning""
Output: true

Two possible strings "good" and "morning" containing two vowels each.
=cut

use constant { true => 1, false => 0};
use Test2::V0;

is(splits_on_vowels('perl'), false, 'Example 1');
is(splits_on_vowels('book'), true, 'Example 2');
is(splits_on_vowels('goodmorning'), true, 'Example 3');
is(actually_split_on_vowels('perl'), false, 'Example 1A');
is(actually_split_on_vowels('book'), true, 'Example 2A');
is(actually_split_on_vowels('goodmorning'), true, 'Example 3A');

done_testing();




sub splits_on_vowels
{
     my $string = $_[0];
     my $re_vowels = qr/[aeiouy]/i;
     my $count = () = $string =~ /$re_vowels/g;
     return ($count == 0 or $count % 2 == 1) ? false : true;
}



sub actually_split_on_vowels
{
     my $string = $_[0];
     my $re_vowels = qr/[aeiouy]/i;

     if ( length($string) == 1)
     {
          return false;
     }
     elsif ( length($string) == 2 )
     {
          return 
          (substr($string, 0, 1) =~ /$re_vowels/ 
               and substr($string, -1, 1) =~ /$re_vowels/) ? true : false;
     }
     else
     {
          for my $idx ( 1 .. length($string) - 1 )
          {
               my $count_1 = () = substr($string, 0, $idx) =~ /$re_vowels/g;
               my $count_2 = () = substr($string, $idx) =~ /$re_vowels/g;
               if ( $count_1 == $count_2 )
               {
                    return true;
               }
          }
     }
     return false;
}