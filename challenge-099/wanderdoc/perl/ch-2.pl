#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two strings $S and $T. Write a script to find out count of different unique subsequences matching $T without changing the position of characters.
Example 1: Input: $S = "littleit', $T = 'lit' Output: 5
    1: [lit] tleit
    2: [li] t [t] leit
    3: [li] ttlei [t]
    4: litt [l] e [it]
    5: [l] ittle [it]

Example 2: Input: $S = "london', $T = 'lon' Output: 3
    1: [lon] don
    2: [lo] ndo [n]
    3: [l] ond [on]
=cut
use Test::More;

sub find_subsequence
{
     my ($str_1, $str_2) = @_;

     my $mtr;

     my @first  = split(//,$str_1);
     my @second = split(//,$str_2);

     do { my $ch1 = $_;
          do { $mtr->[$ch1][$_] = 0 } for 0 .. scalar @second }
          for 0 .. scalar @first;
     $mtr->[$_][0] = 1 for 0 .. scalar @first;

     for my $i ( 1 .. scalar @first )
     {
          for my $j ( 1 .. scalar @second )
          {


               if($first[$i-1] eq $second[$j-1])
               {
                    $mtr->[$i][$j] += $mtr->[$i-1][$j] + $mtr->[$i-1][$j-1];
               }
               else
               {
                    $mtr->[$i][$j] += $mtr->[$i-1][$j];
               }

          }
     }
     return $mtr->[-1][-1];
}

is(find_subsequence(qw(littleit lit)), 5, 'Example 1');
is(find_subsequence(qw(london lon)), 3, 'Example 2');
is(find_subsequence(qw(trace car)), 0, 'Example with 0');

done_testing();