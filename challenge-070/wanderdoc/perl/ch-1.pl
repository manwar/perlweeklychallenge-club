#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $S of size $N. You are also given swap count $C and offset $O such that $C >= 1, $O >= 1 and $C + $O <= $N.

Write a script to perform character swapping like below:
$S[ 1 % $N ] <=> $S[ (1 + $O) % $N ]
$S[ 2 % $N ] <=> $S[ (2 + $O) % $N ]
$S[ 3 % $N ] <=> $S[ (3 + $O) % $N ] ...
$S[ $C % $N ] <=> $S[ ($C + $O) % $N ]

Example 1
Input: $S = 'perlandraku' $C = 3 $O = 4

Character Swapping:
    swap 1: e <=> n = pnrlaedraku
    swap 2: r <=> d = pndlaerraku
    swap 3: l <=> r = pndraerlaku

Output:  pndraerlaku

Example 2
Input: $S = 'weeklychallenge' $C = 5 $O = 2

Character Swapping:
    swap 1: e <=> k = wkeelychallenge
    swap 2: e <=> l = wkleeychallenge
    swap 3: e <=> y = wklyeechallenge
    swap 4: e <=> c = wklyceehallenge
    swap 5: e <=> h = wklycheeallenge

Output: wklycheeallenge
=cut

use Test::More;



sub swapping
{
     my $string = $_[0];

     my $count = $_[1];
     my $offset = $_[2];
     my $len = length($string);


     my $i = 1;

     while ( $i <= $count )
     {
          (substr($string, $i % $len, 1), substr($string, ($i + $offset) % $len, 1)) =
          (substr($string, ($i + $offset) % $len, 1), substr($string, $i % $len, 1));
          $i++;
     }

     return $string;
}
is(swapping('perlandraku', 3, 4), 'pndraerlaku', 'Example 1');
is(swapping('weeklychallenge', 5, 2), 'wklycheeallenge', 'Example 2');
done_testing();