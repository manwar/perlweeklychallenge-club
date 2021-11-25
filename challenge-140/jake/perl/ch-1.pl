#!/r/bin/perl
use strict;
use warnings;

# with this script you can add 2 binary numbers and get their sum as binary number
# https://theweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK1

# get input of 2 binary numbers

print "binary number a: ";
my $binary_input_a = <STDIN>;
print "binary number b: ";
my $binary_input_b = <STDIN>;
chomp ( $binary_input_a, $binary_input_b );


# convert binaries to decimals

my $a_decimal = binary_to_decimal ( $binary_input_a );
my $b_decimal = binary_to_decimal ( $binary_input_b );


# perform regular addition on decimals

my $result_decimal = $a_decimal + $b_decimal;


# convert decimal results to binary

my $result_binary = decimal_to_binary ( $result_decimal );
print "$result_binary\n";

###
# convert decimals to binaries
#
# each n-th power of 2 in decimal translates to the n-th power of 10 in binary:
# n=0: 1>1 | n=1: 2>10 | n=2: 4>100 and so on, we know the drill.
# For conversion, we first determine the largest power contained in the decimal number.
# Next, we subtract this power from our decimal and determine the largest power in this 'remainder'.
# This is repeated until there is no remainder left.
# For each n-th power of 2 we add a binary quantum to an accumulator.
# At the end of our 'run for power' this accumulator is our binary equivalent to our decimal.
###

# container sub so main needs to pass only 1 argument
sub decimal_to_binary {
    my ( $decimal ) = @_;

    return _decimal_to_binary ( 0, $decimal );
}

sub _decimal_to_binary {
    my ( $power, $decimal_number, $binary_quantum ) = @_;

    # special case of 0
    if ( $decimal_number == 0 ) {
        return 0;
    }

    # any decimal or remainder hitting exactly an n-th power of 2 will eventually finish the run here
    if ( $decimal_number == 2**$power ) {
        $binary_quantum += 10**$power;
        return $binary_quantum; 
    }

    # if a number will not finish at the previous step, we check if the number is between the current power or the next one.
    # if it is, we know the largest power to 2 in this number is the current power, so we have to add this power to 10 to our binary quantum accumulator.
    # we then take the remainder (what comes on top of the current power to 2) and investigate its powers.
    # p.e. our decimal is 9.
    # since 2^3 < 9 < 2^4, we add 10^3 to our binary quant.
    # then we perform 9-2^3 = 1 to get the remainder which needs to be quantized itself.
    # 1 is our remaining decimal, which we re-investigate starting again with power = 0.
    if ( $decimal_number > 2**$power && $decimal_number < 2**( $power +1 ) ) {
        $binary_quantum += 10**$power;
        $decimal_number -= 2**$power;
        $power = 0;
        return _decimal_to_binary ( $power, $decimal_number, $binary_quantum );
    }

    # this operation is needed whenever our decimal is larger than our current power to 2 and the next one.
    $power++;
    return _decimal_to_binary ( $power, $decimal_number, $binary_quantum );
}

###
# convert binaries to decimals
#
# We investigate each digit of our binary number starting from the back.
# Every digit represents the next power to 2, so we count the digits as we run towards the front of the binary.
# For each digit we check if it's 1 or 0.
# Whenever we hit a 1 we use the digit count as power to 2 and add the result to our accumulator.
# Once we reach the beginning of our binary, we will have accumulated our decimal.
###

# container sub so main needs to pass only 1 argument
sub binary_to_decimal {
    my ( $binary ) = @_;

    return _binary_to_decimal ( $binary, 0, 0 );
}

sub _binary_to_decimal {
    my ( $binary_number, $power, $acc, $tail ) = @_;

    # once we reach the beginning of our binary the string will be empty, since in each iteration we chop the tail off of our binary
    return $acc if $binary_number eq '';

    $tail = chop ($binary_number);

    if ( $tail == 1 ) {
        $acc += 2**$power;
        $power++;
        return _binary_to_decimal ( $binary_number, $power, $acc );
    }

    if ( $tail == 0 ) {
        $power++;
        return _binary_to_decimal ( $binary_number, $power, $acc );
    }
}