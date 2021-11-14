#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a perfect square. Write a script to figure out if the square root the given number is same as sum of 2 or more splits of the given number.
Example 1 Input: $n = 81 Output: 1 Since, sqrt(81) = 8 + 1
Example 2 Input: $n = 9801 Output: 1 Since, sqrt(9801) = 98 + 0 + 1
Example 3 Input: $n = 36 Output: 0 Since, sqrt(36) != 3 + 6
=cut








use Algorithm::Combinatorics qw(partitions);
use List::Util qw(first sum reduce);
use Test::More;

sub split_number
{
     my $num = $_[0];

     my $sqrt = sqrt($num);
     die "Error: $num is not a perfect square.$/" unless $sqrt == int($sqrt);
     my @digits = split(//, $num);
     my $iter = partitions(\@digits);
     while (my $p = $iter->next) 
     {
          my @parts = map join('', @$_), @$p;
          next if scalar @parts == 1;
          next if join('', @parts) != $num;
          next if first { /^0{2,}$|^0+[^0]+$/ } @parts; # ?
          next if first { $_ > $sqrt } @parts; 
          next if substr(sum( map { substr($_, -1, 1) } @parts ), -1, 1) != substr($sqrt, -1, 1);


          if ( sum(@parts) == $sqrt )
          {
               print "@parts$/";
               return 1;
          }
     }
     return 0;
}

is(split_number(81), 1, 'Test 81');
is(split_number(9801), 1, 'Test 9801');
is(split_number(36), 0, 'Test 36');
is(split_number(999998000001), 1, 'Test 999998000001');
is(split_number(15241383936), 0, 'Test 15241383936');
done_testing();