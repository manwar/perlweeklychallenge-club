# Formatted Multiplication Table
#
# Write a script to print 11x11 multiplication table, only the top half triangle.
#
#   x|   1   2   3   4   5   6   7   8   9  10  11
#   ---+--------------------------------------------
#   1|   1   2   3   4   5   6   7   8   9  10  11
#   2|       4   6   8  10  12  14  16  18  20  22
#   3|           9  12  15  18  21  24  27  30  33
#   4|              16  20  24  28  32  36  40  44
#   5|                  25  30  35  40  45  50  55
#   6|                      36  42  48  54  60  66
#   7|                          49  56  63  70  77
#   8|                              64  72  80  88
#   9|                                  81  90  99
#  10|                                     100 110
#  11|                                         121
#

sub print_mult_table($size) {
    # Determine the gap between the numbers.
    my $gap = ceiling(log10($size * $size)) + 1;

    print " " x $gap - 1;
    print "x|";
    for 1..$size -> $i {
        print($i.fmt('%' ~ $gap ~ 'd'));
    }
    print "\n";

    print "-" x $gap ~ "+" ~ "-" x $size * $gap ~ "\n";

    for 1..$size -> $i {
        print $i.fmt('%' ~ $gap ~ 'd') ~ "|" ~ " " x ($i - 1) * $gap;
        for $i..$size -> $j {
            print ($i * $j).fmt('%' ~ $gap ~ 'd');
        }
        print "\n";
    }
}

print_mult_table(3);
print_mult_table(8);
print_mult_table(11);
print_mult_table(40);
