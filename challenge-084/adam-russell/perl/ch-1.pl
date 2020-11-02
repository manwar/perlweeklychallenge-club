use strict;
use warnings;
##
# You are given an integer $N.
# Write a script to reverse the given integer and print the result. 
# Print 0 if the result doesn’t fit in 32-bit signed integer.
##
use Config;
use boolean;
use constant MAX_32BIT_SIGNED => 2_147_483_647;

sub reverse_digits{
    my($n) = @_;
    return 0 if $n > MAX_32BIT_SIGNED || $n < -1*MAX_32BIT_SIGNED;
    my $negative = $n < 0 ? true : false;
    $n = abs($n) if $negative;
    return join("", reverse split(//, $n)) if !$negative;
    return "-" . join("", reverse split(//, $n));
}

MAIN:{
    my $A = $ARGV[0];
    print reverse_digits($A) . "\n";   
}