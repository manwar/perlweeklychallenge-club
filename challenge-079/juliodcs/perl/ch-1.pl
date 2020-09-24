#!perl

# This code is way longer than my initial approach:
#
#  $total += count_ones to_binary $number-- while $number > 0;
#  say $total % 1000000007;
#
# But at the same time it should be much faster
# since the cost is logarithmic
#
# Try me with big numbers!

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use constant MODULE       => 1000000007;
use constant INTEGER_LAST => 2**63 - 1;

use constant W_ACCURATE   => 'Warning: intermediate result > Integer\'last. Result *may* not be accurate!';
use constant E_ACCURATE   => 'Error: Number cannot be > Integer\'last';
use constant E_NO_NUMBER  => 'You need to submit a number';

sub length_bin($number) {
    length sprintf '%b', $number;
}

# Given a number, it calculates the flips of the most-significant-bit number
# e.g., ms-flips of 13 (1101) returns the number of flips for number 8 (1000)
sub score($number) {
    return 1 if $number == 1;
    1 + ( length_bin($number) - 1 ) * 2**( length_bin($number) - 2 );
}

# Remove most significat bit and return number
sub next_number($number) {
    $number - 2**( length_bin($number) - 1 );
}

sub calculate ( $number, $total = 0 ) {
    if ( $number == 0 ) {
        say {*STDERR} W_ACCURATE if $total > INTEGER_LAST;
        return $total % MODULE;
    }

    # All bits besides the first need extra flips
    # extra flips are equal to the number itself
    my $extra = $total == 0 ? 0 : $number;

    # Use tail call optimization
    @_ = ( next_number($number), $total + score($number) + $extra );
    goto &calculate;
}

my $number = shift // q();

die E_NO_NUMBER if $number !~ m{^\d+$}sxm;

die E_ACCURATE if $number > INTEGER_LAST;
    
say 'Result: ' . calculate($number);
