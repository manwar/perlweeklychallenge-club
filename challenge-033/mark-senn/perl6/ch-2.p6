#
# Perl Weekly Challenge - 033
# Task #2
#
# Mark Senn, http://engineering.purdue.edu/~mark
# November 10, 2019
#
# From
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-033#task-2
#      Write a script to print 11x11 multiplication table,
#      only the top half triangle.
#
#       x|   1   2   3   4   5   6   7   8   9  10  11
#     ---+--------------------------------------------
#       1|   1   2   3   4   5   6   7   8   9  10  11
#       2|       4   6   8  10  12  14  16  18  20  22
#       3|           9  12  15  18  21  24  27  30  33
#       4|              16  20  24  28  32  36  40  44
#       5|                  25  30  35  40  45  50  55
#       6|                      36  42  48  54  60  66
#       7|                          49  56  63  70  77
#       8|                              64  72  80  88
#       9|                                  81  90  99
#      10|                                     100 110
#      11|                                         121
#     

# Run using Raku v6.d;
use v6.d;

# Print first two lines.
# I just cut and pasted the lines from the problem
# description so it would be easy to see if the
# spacing was correct in the rest of the table.
print q:to/END/;
  x|   1   2   3   4   5   6   7   8   9  10  11
---+--------------------------------------------
END

# Print rest of table.
my $n = 11;
for (1..$n) -> $row
{
    "%3d|".printf($row);
    for (1..$n) -> $col
    {
        ($col < $row)
        ??  "    ".print
        !!  "%4d".printf($row*$col);
    }
    ''.say;
}
