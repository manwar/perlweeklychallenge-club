# This code is way longer than my initial approach:
#
#  $total += count_ones to_binary $number-- while $number > 0;
#  say $total % 1000000007;
#
# But at the same time it should be much faster
# since the cost is logarithmic
#
# Try me with big numbers!

constant \MODULE = 1000000007;

# Given a number, it calculates the flips of the most-significant-bit number
# e.g., ms-flips of 13 (1101) returns the number of flips for number 8 (1000)
sub ms-flips(UInt:D \number) returns UInt:D {
    number == 1 ?? 1 !! 1 + number.msb * 2 ** (number.msb - 1)
}

# Remove most significat bit and return number
sub next-number(UInt:D \number) returns UInt:D {
    number - 2 ** number.msb
}

sub calculate(UInt:D \number, UInt:D \accumulator = 0) returns UInt:D {
    return accumulator % MODULE if number == 0;

    # All bits besides the first need extra flips
    # extra flips are equal to the number itself
    my \extra-flips = accumulator == 0 ?? 0 !! number;
    my \next-accumulator = accumulator + ms-flips(number) + extra-flips;

    calculate next-number(number), next-accumulator
}

sub MAIN(UInt:D \number) returns Nil {
    say 'Result: ' ~ calculate number;
    return;
}
