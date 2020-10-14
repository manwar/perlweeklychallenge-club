#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

sub count_candies {
    my ($n) = @_;
    return 1 if 1 == @$n;

    my @candies;
    $candies[0]    = 0 if $n->[0]  <= $n->[1];
    $candies[$#$n] = 0 if $n->[-1] <= $n->[-2];
    for my $i (1 .. $#$n - 1) {
        $candies[$i] = 0 if $n->[$i] <= $n->[$i - 1]
                         && $n->[$i] <= $n->[$i + 1];
    }
    my ($solved, $solved_before) = (0, -1);
    while ($solved_before != $solved) {
        $solved_before = $solved;
        for my $pos (0 .. $#$n) {
            for my $neighbour ($pos - 1, $pos + 1) {
                next if $neighbour < 0 || $neighbour > $#$n;

                # Derive the candies for the current candidate on their
                # neighbour. If the candidate has a higher rank, it should get
                # one more than the neighbour. If the other neighbour has a
                # lower rank than the candidate but gets more candies, the
                # candidate should get one more.
                ++$solved, $candies[$pos] = $candies[$neighbour] + 1
                    if defined $candies[$neighbour]
                    && $n->[$neighbour] < $n->[$pos]
                    && (! defined $candies[$pos]
                        || $candies[$pos] <= $candies[$neighbour]);
            }
        }
    }
    return @$n + sum(@candies)
}

use Test::More;
is count_candies([3]), 1;
is count_candies([5, 5, 5, 5]), 4;
is count_candies([1, 2, 2]), 4;
is count_candies([1, 4, 3, 2]), 7;
is count_candies([1, 2, 5, 4, 3, 2, 1]), 18;
is count_candies([1, 2, 3, 7, 6, 5, 4, 3, 2, 2, 2, 1]), 31;
is count_candies([3, 2, 1]), 6;
is count_candies(
    [1, 9, 10, 10, 0, 8, 9, 6, 2, 8, 0, 1, 3, 3, 1, 10, 1, 3, 8, 8]
), 37;

is count_candies([qw[ 1 9 5 2 6 8 9 10 2 5 1 ]]), 25, 'Colin';

done_testing();

__END__

=head1 Debugging

Add

  warn join '|', map $_ // ' ', @candies;

to the top of the while loop.

=head1 Example

  1 2 3 7 6 5 4 3 2 2 2 1
  -----------------------
  0| | | | | | | |0|0| |0 <- minima
  0|1|2|3| | | |1|0|0|1|0 <- based on neighbours
  0|1|2|3| | |2|1|0|0|1|0  .
  0|1|2|3| |3|2|1|0|0|1|0  .
  0|1|2|3|4|3|2|1|0|0|1|0  .
  0|1|2|5|4|3|2|1|0|0|1|0 <- change based on the other neighbour
        ^

=cut
