#!/usr/bin/perl

# Challenge 141
#
# TASK #2 > Like Numbers
# Submitted by: Mohammad S Anwar
# You are given positive integers, $m and $n.
#
# Write a script to find total count of integers created using the digits
# of $m which is also divisible by $n.
#
# Repeating of digits are not allowed. Order/Sequence of digits can't be
# altered. You are only allowed to use (n-1) digits at the most. For example,
# 432 is not acceptable integer created using the digits of 1234. Also for
# 1234, you can only have integers having no more than three digits.
#
# Example 1:
# Input: $m = 1234, $n = 2
# Output: 9
#
# Possible integers created using the digits of 1234 are:
# 1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134 and 234.
#
# There are 9 integers divisible by 2 such as:
# 2, 4, 12, 14, 24, 34, 124, 134 and 234.
# Example 2:
# Input: $m = 768, $n = 4
# Output: 3
#
# Possible integers created using the digits of 768 are:
# 7, 6, 8, 76, 78 and 68.
#
# There are 3 integers divisible by 4 such as:
# 8, 76 and 68.

use Modern::Perl;

sub numbers {
    my($num) = @_;
    my @ret;

    my $mask_n = 0;
    for (;; $mask_n++) {
        my $mask = sprintf("%0".length($num)."b", $mask_n);
        last if length($mask) > length($num);

        # combine $num with $mask
        my $res = 0;
        for my $i (0 .. length($num)-1) {
            if (substr($mask, $i, 1) eq "1") {
                $res = 10*$res + substr($num, $i, 1);
            }
        }
        push @ret, $res;
    }
    return @ret;
}

my($m, $n) = @ARGV;
my $count = 0;
for my $num (numbers($m)) {
    if ($num != 0 && $num != $m) {
        if ($num % $n == 0) {
            $count++;
        }
    }
}
say $count;
