# You are given an integer $N.
#
# Write a script to check if the given number can be expressed as mn where m
# and n are positive integers. Otherwise print 0.
#
# Please make sure m > 1 and n > 1.
#
# BONUS: If there are more than one ways to express the given number then print
# all possible solutions.
#
# Example 1:
#
# For given $N = 9, it should print 32 or 3^2.
# Example 2:
#
# For given $N = 45, it should print 0.
# Example 3:
#
# For given $N = 64, it should print all or one of 8^2 or 2^6 or 4^3.

sub power-int($n) {
    my @r = ((2..$n**.5) X (2..$n**.5)).grep({ $_[0] ** $_[1] eq $n});

    if (@r.elems == 0) {
        say 0;
    } else {
        say "$_[0]^$_[1]" for @r;
    }
}

say "Example 1, N=9:";
power-int(9);

say "Example 2, N=45:";
power-int(45);

say "Example 3, N=64:";
power-int(64);
