#!/usr/bin/perl
use strict;
use Scalar::Util::Numeric qw(isint);
use Math::BigInt;
use Math::BigFloat;

####  Smallest Multiple
####  Write a script to accept a positive number as command line argument and 
####  print the smallest multiple of the given number consists of digits 0 and 1.
####  Solution by ianrifkin

####  Assumption 1: the smallest multiple will ONLY have digits 0 and 1
####  Assumption 2: Multiples are at least double the input (e.g. the multiple of 100 is 1000 and not 100)

my $input = $ARGV[0];

die("Input must be a positive number") unless $input > 0;


# You could loop through every number and check if it's correct
# For smaller answers like when $input = 2, or 5, or 100 it's quick
# But when $input is 9 you can see how this starts to take too long to find the answer
# and input = 99 is way too long to wait.

# Instead b/c of assumption #1 we know that the answer will be 
# only 0's and 1's we can do math using only binary numbers

# subroutine taken from Perl Cookbook to convert decimals to binaries
sub dec2bin {
    my $str = unpack("B32", pack("N", shift));
    $str =~ s/^0+(?=\d)//;   # otherwise you'll get leading zeros
    return $str;
}

# for example when input = 9 in the first commented out method
# it would take 1011111110 loops to get to 1011111111
# But in this method it only takes 766 loops.

my $i = 2;
my $output = undef;
while ($output == undef) {
    my $bin_i = dec2bin($i);
    $i++ and next unless $bin_i =~ /^1[1]*[0]+[0-1]*$/;
    my $test = Math::BigFloat->new($bin_i);
    $test->bdiv($input);
    $output = $bin_i if $test == $test->as_int() and $input != $bin_i;
    $i++;
    #Consider if there needs to be an emergency exit after too many iterations
    #without finding an answer
}

print "\n\nThe smallest multiple of $input with only digits 0 and 1 is: $output\n\n";

# Note on BigFloat
# My first attempt was to Scalar::Util::Numeric (or INT, POSIX or ROUND) to check 
# if binary/input is an int  e.g. check $test == isint($test)
# But this would return incorrect results when inputting a number like 99 because 
# it was incorrectly rounding $test (too many digits?)
# Using Math::BigFloat instead solves this problem but it's a major performance hit.
