#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an alphabetic strings, $str, as typed by user.

Write a script to find the number of times user had to change the key to type the given string. Changing key is defined as using a key different from the last used key. The shift and caps lock keys won't be counted.
Example 1

Input: $str = 'pPeERrLl'
Ouput: 3

p -> P : 0 key change
P -> e : 1 key change
e -> E : 0 key change
E -> R : 1 key change
R -> r : 0 key change
r -> L : 1 key change
L -> l : 0 key change

Example 2

Input: $str = 'rRr'
Ouput: 0

Example 3

Input: $str = 'GoO'
Ouput: 1
=cut

use Test2::V0;

is(changing_key('pPeERrLl'), 3, 'Example 1');
is(changing_key('rRr'), 0, 'Example 2');
is(changing_key('GoO'), 1, 'Example 3');
done_testing();

sub changing_key
{
     my $str = $_[0];
     my %letters;
     $letters{$_} = undef for map lc, split(//, $str);
     return scalar (keys %letters) - 1;
}