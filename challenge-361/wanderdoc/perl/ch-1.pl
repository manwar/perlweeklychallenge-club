#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer (<= 100).

Write a script to return Zeckendorf Representation of the given integer.

    Every positive integer can be uniquely represented as sum of non-consecutive Fibonacci numbers.

Example 1

Input: $int = 4
Output: 3,1

4 => 3 + 1 (non-consecutive fibonacci numbers)


Example 2

Input: $int = 12
Output: 8,3,1

12 => 8 + 3 + 1


Example 3

Input: $int = 20
Output: 13,5,2

20 => 13 + 5 + 2


Example 4

Input: $int = 96
Output: 89,5,2

96 => 89 + 5 + 2


Example 5

Input: $int = 100
Output: 89,8,3

100 => 89 + 8 + 3

=cut


use Test2::V0 -no_srand => 1;
# use bignum; # s. sub fib_approx below.


is([represented(4)], [3, 1], 'Example 1');
is([represented(12)], [8, 3, 1], 'Example 2');
is([represented(20)], [13, 5, 2], 'Example 3');
is([represented(96)], [89, 5, 2], 'Example 4');
is([represented(100)], [89, 8, 3], 'Example 5');
done_testing();


sub fib_approx
{
     my $num = $_[0];
     my $ratio = (1 + sqrt(5))/2;
     my @fib_array;
     my $i = 0;
     my $fib_num = 1;
     $fib_array[$i] = $fib_num;
     while ( $fib_num < $num )
     {
          $i++;
          $fib_num = int($fib_num * $ratio + 0.5); # correct at least until fib(100) (with bignum, without bignum: correct until fib(75))
          $fib_array[$i] = $fib_num;
     }
     return \@fib_array;
}


sub represented
{
     my $num = $_[0];
     my $fibonacci = fib_approx($num);
     my @sorted = 
          grep { $_ < $num }
          sort {$b <=> $a} @$fibonacci;
     my @output;

     my $old_idx; 
     while ( $num > 0 )
     {
          for my $idx ( 0 .. $#sorted )
          {
               next if ( $old_idx and ($idx - $old_idx) == 1 );
               my $part = $sorted[$idx];
               next unless $part <= $num;
               $num -= $part;
               $old_idx = $idx;
               push @output, $part;
               last if $num == 0;
          }
     }
     return @output;
}
