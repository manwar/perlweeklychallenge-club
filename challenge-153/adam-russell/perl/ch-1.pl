use strict;
use warnings;
##
# Write a script to determine the first ten members of the Left Factorials sequence.
##
use POSIX;
use constant UPPER_BOUND => INT_MAX/1000;

sub left_factorials_sieve{
    my($n) = @_;
    my @sieve = (0 .. UPPER_BOUND);
    my $x = 2;
    {
        my @sieve_indices = grep { $_ <= $x || $_ % $x == 0 } 0 .. @sieve - 1; 
        @sieve = map{ $sieve[$_] } @sieve_indices;
        $x++;
        redo if $x <= $n;
    }
    return @sieve[1 .. @sieve - 1];
}

MAIN:{
    print join(", ", left_factorials_sieve(10)) . "\n";
}