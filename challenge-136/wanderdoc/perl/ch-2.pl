#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive number $n. 
Write a script to find how many different sequences you can create using Fibonacci numbers where the sum of unique numbers in each sequence are the same as the given number.
Example 1
Input:  $n = 16
Output: 4
Reason: There are 4 possible sequences that can be created using Fibonacci numbers
i.e. (3 + 13), (1 + 2 + 13), (3 + 5 + 8) and (1 + 2 + 5 + 8).

Example 2
Input:  $n = 9
Output: 2
Reason: There are 2 possible sequences that can be created using Fibonacci numbers
i.e. (1 + 3 + 5) and (1 + 8).

Example 3
Input:  $n = 15
Output: 2
Reason: There are 2 possible sequences that can be created using Fibonacci numbers
i.e. (2 + 5 + 8) and (2 + 13).
=cut

use constant {ROOT5 => sqrt(5)}; 
use constant { GR => (1 + ROOT5) / 2 };

my $number = shift;
die "Need a number (positive integer above 2)!$/" unless ($number and $number > 2 and $number == int($number));

my @coins;
my $fib_num = 2;
while ( (my $this_fib = fib($fib_num++)) < $number )
{
     unshift @coins, $this_fib;
}


my $table = [];
my @SOLS;
solve($table, $number, @coins);

my $count = 1;
for my $t ( @SOLS) 
{ 
     print $count++, ': ', join("+", @$t), $/; 

}


sub solve
{
     no warnings 'recursion';
     my ($solution, $remain, @arr) = @_;


     if ( $remain == 0 )
     {
          my $s = deep_copy($solution);
          push @SOLS, $s;
     }

     for my $idx ( 0 .. $#arr )
     {

          next if ( $arr[$idx] > $remain );
          next if ( $solution->[-1] and $solution->[-1] == $arr[$idx] );
          push @{$solution}, $arr[$idx];
          $remain -= $arr[$idx];
          my $next = $idx == $#arr ? $#arr : $idx + 1;
          if ( solve($solution, $remain, @arr[$next .. $#arr] ) )
          {
               return $solution;

          }
          $remain += pop @{$solution};
     }
     return 0;
}




sub deep_copy
{
     my $aref = shift;
     my @arr;
     push @arr, $_  for @$aref;
     return [@arr];
}


sub fib
{
     my $n = $_[0];
     die "Need a positive integer!$/" unless ($n > 0 and $n == int($n));
     return int( ((GR ** $n) / ROOT5) + 0.5 );
}