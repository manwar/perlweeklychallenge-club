#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [N D]

-examples
    run the examples from the challenge
 
N
    number to be broken down into summands

D
    digit to appear in summands

EOS


### Input and Output

my ($n, $d) = @ARGV;
say rep_int($n, $d);


### Implementation

# Some considerations:
# - The task neither requires the summands to be distinct nor a solution
#   to have more than one summand.
# - Every integer n that is a multiple of the digit d can be represented
#   as a multiple sum of the given digit.
# - Every integer having d in its decimal representation is a solution
#   with itself as the sole summand.
# - For all d > 0 and 10 * d <= n < 10 * (d + 1) the number starts
#   with the digit d and thus is a solution itself.
# - For all d > 0 and 10 * (d + 1) <= n there is a number m with
#   10 * d <= m < 10 * (d + 1) starting with d and n - m is a multiple
#   of d.  Thus n is representable as a sum of numbers that have the
#   digit d in their decimal representation.
# - For d = 0 and 100 <= n an analogous consideration is applicable when
#   taking d=10 instead.  As leading zeros do not count, with the taken
#   modification the second digit becomes zero.
# - The remaining cases are n < 10 * d with the modified d.  Further
#   analysis can be applied to these, e.g checking the special cases
#   where d is one, even or five or is already occurring in n.  However,
#   skipping any refinements and performing a brute force approach on
#   this small solution space instead.

sub rep_int ($n, $d) {
    $d ||= 10;
    return 1 if $n >= $d * 10;

    # keys are strings, using the numeric values.
    my %sum = (0 => 0);

    # All numbers containing the digit $d.
    for (my $num = $d; $num <= $n; $num += 10) {
        # All sums found so far.
        for my $sum (values %sum) {
            # New sums arise from the current sum plus multiples of the
            # current number.
            for (my $new = $sum + $num; $new <= $n; $new += $num) {
                return 1 if $new == $n;
                $sum{$new} = $new;
            }
        }
    }

    # Not found.
    0;
}




### Examples and tests

sub run_tests {

    is rep_int(25, 7), F(), 'example 1';
    is rep_int(24, 7), T(), 'example 2';

    done_testing;
    exit;
}
