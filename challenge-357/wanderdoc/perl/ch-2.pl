#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Given a positive integer N, generate all unique fractions you can create using integers from 1 to N and follow the rules below:

- Use numbers 1 through N only (no zero)
- Create fractions like numerator/denominator
- List them in ascending order (from smallest to largest)
- If two fractions have the same value (like 1/2 and 2/4),
  only show the one with the smallest numerator

Example 1

Input: $int = 3
Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

Example 2

Input: $int = 4
Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1


Example 3

Input: $int = 1
Output: 1/1


Example 4

Input: $int = 6
Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
        4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
        5/2, 3/1, 4/1, 5/1, 6/1


Example 5

Input: $int = 5
Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
        5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1

=cut




use Test2::V0 -no_srand => 1;

is(fractions_generator(3),
     '1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1', 'Example 1');
is(fractions_generator(4),
     '1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1', 'Example 2');
is(fractions_generator(1),
     '1/1', 'Example 3');
is(fractions_generator(6),
     '1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1, 6/1', 'Example 4');
is(fractions_generator(5),
     '1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1', 'Example 5');
done_testing();

sub fractions_generator
{
     my $int = $_[0];
     my %fractions;
     my $sprintf_format = "%0." . (length($int) + 1) . "f"; 
     for my $num_1 ( 1 .. $int )
     {
          for my $num_2 ( 1 .. $int )
          {
               my $this_fraction = sprintf($sprintf_format, $num_1 / $num_2);
               $fractions{$this_fraction} ||= join('/', $num_1, $num_2);
          }
     }
     return join(', ',
            map { $fractions{$_}}
            sort {$a <=> $b} 
            keys %fractions);
}
