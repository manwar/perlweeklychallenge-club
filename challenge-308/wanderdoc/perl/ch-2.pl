#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an encoded array and an initial integer.

Write a script to find the original array that produced the given encoded array. It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].
Example 1

Input: @encoded = (1, 2, 3), $initial = 1
Output: (1, 0, 2, 1)

Encoded array created like below, if the original array was (1, 0, 2, 1)
$encoded[0] = (1 xor 0) = 1
$encoded[1] = (0 xor 2) = 2
$encoded[2] = (2 xor 1) = 3

Example 2

Input: @encoded = (6, 2, 7, 3), $initial = 4
Output: (4, 2, 0, 7, 4)
=cut

use Test2::V0 -no_srand => 1;

is(decode_xor([1, 2, 3], 1), [1, 0, 2, 1], 'Example 1');
is(decode_xor([6, 2, 7, 3], 4), [4, 2, 0, 7, 4], 'Example 2');
done_testing();

sub decode_xor
{
     my ($enc_aref, $initial) = @_;
     my @original = ($initial);
     for my $elm ( @$enc_aref )
     {
          my $xored = $elm ^ $original[-1]; 
          push @original, $xored;
     }
     return \@original;
}