# You are given two integers $M and $N.
#
# Write a script to divide the given two integers i.e. $M / $N without using
# multiplication, division and mod operator and return the floor of the result
# of the division.
#
# Example 1:
#
# Input: $M = 5, $N = 2
# Output: 2
#
# Example 2:
#
# Input: $M = -5, $N = 2
# Output: -3
#
# Example 3:
#
# Input: $M = -5, $N = -2
# Output: 2

# multi tedious-div($m, $n) {
#     if ($m > 0 && $n > 0) {
#         return ($n, {$_ + $n} ... ^ * > $m);
#     } elsif ($m < 0 && $n < 0) {
#         return tedious-div(-$m, -$n);
#     } elsif ($m > 0 && $n < 0) {
#         return (-$n, {$_ - $n} ... ^ * > $m);
#     } else {
#         return tedious-div(-$m, -$n);
#     }
# }

sub tedious-div($m, $n) {
    if (abs($m) < abs($n)) {
        if ($m >= 0) {
            return 0;
        } else {
            return -1;
        }
    } elsif ($m > 0 && $n > 0) {
        return 1 + tedious-div($m - $n, $n);
    } elsif ($m < 0 && $n > 0) {
        return -1 + tedious-div($m + $n, $n);
    } else {
        return tedious-div(-$m, -$n);
    }
}

tedious-div(5, 2).say;
tedious-div(-5, 2).say;
tedious-div(-5, -2).say;
tedious-div(5, -2).say;
