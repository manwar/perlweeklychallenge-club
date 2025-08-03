#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.
Write a script to find out if each letter in the given string appeared odd number of times.

Example 1

Input: $str = "weekly"
Output: false

w: 1 time
e: 2 times
k: 1 time
l: 1 time
y: 1 time

The letter 'e' appeared 2 times i.e. even.


Example 2

Input: $str = "perl"
Output: true


Example 3

Input: $source = "challenge"
Output: false

=cut

use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;



is(odd_letters('weekly'), false, 'Example 1');
is(odd_letters('perl'), true, 'Example 2');
is(odd_letters('challenge'), false, 'Example 3');
done_testing();

sub odd_letters
{
     my $str = $_[0];
     my %letters;
     $letters{$_}++ for split(//, $str);
     for my $num ( values %letters )
     {
          if ( $num % 2 == 0 )
          {
               return false;
          }
     }
     return true;
}
