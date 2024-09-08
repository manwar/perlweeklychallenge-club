#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Compute the number of ways to make change for given amount in cents. By using the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many distinct ways can the total value equal to the given amount? Order of coin selection does not matter.

A penny (P) is equal to 1 cent.
A nickel (N) is equal to 5 cents.
A dime (D) is equal to 10 cents.
A quarter (Q) is equal to 25 cents.
A half-dollar (HD) is equal to 50 cents.

Example 1

Input: $amount = 9
Ouput: 2

1: 9P
2: N + 4P

Example 2

Input: $amount = 15
Ouput: 6

1: D + 5P
2: D + N
3: 3N
4: 2N + 5P
5: N + 10P
6: 15P
=cut


use Test2::V0;
my %COINS = (1 => 'P', 5 => 'N', 10 => 'D', 25 => 'Q', 50 => 'HD');



is(find_partitions(9, [keys %COINS]), 2, 'Example 1');
is(find_partitions(15, [keys %COINS]), 6, 'Example 2');
done_testing();






sub find_partitions 
{
     my ($sum, $numbers) = @_;
     my @output;
     my @stack = ([$sum, []]);
     while (@stack) 
     {
          my ($this_sum, $this_partition) = @{pop @stack};
          if ($this_sum == 0) 
          {
               push @output, $this_partition;
               next;
          }
          for my $num (@$numbers) 
          {
               if ($this_sum >= $num and (!@$this_partition or $num <= $this_partition->[-1])) 
               {
                    push @stack, [$this_sum - $num, [@$this_partition, $num]];
               }
          }
    }
    return scalar @output; # if needed: format_output(@output);
}

sub format_output # if verbose output needed
{
     my @arr = @_;
     my @output_formatted;
     for my $solution ( @arr )
     {
          my %freq;
          do { $freq{$_}++ } for @$solution;
          my $formatted = join("+", map { $freq{$_} . $COINS{$_} } keys %freq);
          push @output_formatted, $formatted;
     }
     return @output_formatted;
}
