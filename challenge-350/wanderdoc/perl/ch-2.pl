#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
If two integers A <= B have the same digits but in different orders, we say that they belong to the same shuffle pair if and only if there is an integer k such that A = B * k. k is called the witness of the pair.

For example, 1359 and 9513 belong to the same shuffle pair, because 1359 * 7 = 9513.

Interestingly, some integers belong to several different shuffle pairs. For example, 123876 forms one shuffle pair with 371628, and another with 867132, as 123876 * 3 = 371628, and 123876 * 7 = 867132.

Write a function that for a given $from, $to, and $count returns the number of integers $i in the range $from <= $i <= $to that belong to at least $count different shuffle pairs.

Example 1

Input: $from = 1, $to = 1000, $count = 1
Output: 0

There are no shuffle pairs with elements less than 1000.


Example 2

Input: $from = 1500, $to = 2500, $count = 1
Output: 3

There are 3 integers between 1500 and 2500 that belong to shuffle pairs.

1782, the other element is 7128 (witness 4)
2178, the other element is 8712 (witness 4)
2475, the other element is 7425 (witness 3)


Example 3

Input: $from = 1_000_000, $to = 1_500_000, $count = 5
Output: 2

There are 2 integers in the given range that belong to 5 different shuffle pairs.

1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142

The witnesses are 2, 3, 4, 5, and 6 for both the integers.


Example 4

Input: $from = 13_427_000, $to = 14_100_000, $count = 2
Output: 11

6 integers in the given range belong to 3 different shuffle pairs, 5 integers belong to 2 different ones.


Example 5

Input: $from = 1000, $to = 5000, $count = 1
Output: 7

There are 7 integers between 1000 and 5000 that belong to at least one shuffle pair:

1035, the other element is 3105 (witness k = 3)
1089, the other element is 9801 (witness k = 9)
1359, the other element is 9513 (witness k = 7)
1386, the other element is 8316 (witness k = 6)
1782, the other element is 7128 (witness k = 4)
2178, the other element is 8712 (witness k = 4)
2475, the other element is 7425 (witness k = 3)
=cut




use Test2::V0 -no_srand => 1;


is(shuffle_pairs(1, 1000, 1), 0, 'Example 1');
is(shuffle_pairs(1500, 2500, 1), 3, 'Example 2');
is(shuffle_pairs(1_000_000, 1_500_000, 5), 2, 'Example 3');
is(shuffle_pairs(13_427_000, 14_100_000, 2), 11, 'Example 4');
is(shuffle_pairs(1000, 5000, 1), 7, 'Example 5');
done_testing();



sub shuffle_pairs
{
     my ($from, $to, $count) = @_;
     my %output;
     for my $int ( $from .. $to )
     {
          my $min = join('', sort {$a <=> $b } split(//, $int));
          my $max = join('', sort {$b <=> $a } split(//, $int));

          my $x = 2;
          while ( $int * $x <= $max )
          {
               my $cand = $int * $x;
               if ( join('', sort {$a <=> $b } split(//, $cand)) == $min )
               {
                    push @{$output{$int}}, [$cand, $x];
               }

               $x++;
          }
     }
     my @wanted = grep { @{$output{$_}} >= $count } keys %output;
     # %output = %output{@wanted}; # perl 5.20.
     # use Data::Dump; dd \%output;
     # As we are asked to return a number, scalar @wanted will do.
     return scalar @wanted;
}
