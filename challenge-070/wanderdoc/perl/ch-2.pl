#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an integer 2 <= $N <= 5.

Write a script to generate $N-bit gray code sequence.
To generate the 3-bit Gray code sequence from the 2-bit Gray code sequence, follow the step below:

2-bit Gray Code sequence [0, 1, 3, 2]


Binary form of the sequence a) S1 = [00, 01, 11, 10]
Reverse of S1 b) S2 = [10, 11, 01, 00]
Prefix all entries of S1 with '0' c) S1 = [000, 001, 011, 010]
Prefix all entries of S2 with '1' d) S2 = [110, 111, 101, 100]
Concatenate S1 and S2 gives 3-bit Gray Code sequence e) [000, 001, 011, 010, 110, 111, 101, 100]
3-bit Gray Code sequence [0, 1, 3, 2, 6, 7, 5, 4]

Example
Input: $N = 4
Output: [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]

=cut

use Test::More;
sub gray_code
{
     my @seq = @{$_[0]};
     my $cnt = $_[1];

     my $bit = $_[2];
     
     while ( $cnt < $bit )
     {
          @seq = map sprintf("%0${cnt}b",$_), @seq;
          my @seq_2 = reverse @seq;


          @seq   = map '0' . $_, @seq;
          @seq_2 = map '1' . $_, @seq_2;
          push @seq, @seq_2;

          @seq = map oct("0b".$_), @seq;
          $cnt++;
     }
     return @seq;

}

is_deeply([gray_code([0, 1, 3, 2], 2, 3)], ([0, 1, 3, 2, 6, 7, 5, 4]), 'Example 1');
is_deeply([gray_code([0, 1, 3, 2], 2, 4)], 
     ([0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]), 'Example 2');
is_deeply([gray_code([0, 1, 3, 2, 6, 7, 5, 4], 3, 4)],
     ([0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]), 'Variation');
done_testing();