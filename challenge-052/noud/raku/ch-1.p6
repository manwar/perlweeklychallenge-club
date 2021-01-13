# Stepping Numbers
#
# Write a script to accept two numbers between 100 and 999. It should then
# print all Stepping Numbers between them.
#
# A number is called a stepping number if the adjacent digits have a difference
# of 1. For example, 456 is a stepping number but 129 is not.


multi sub stepping-numbers($start, 0) {
    [[$start],];
}

multi sub stepping-numbers($start, $size) {
    gather {
        if ($start != 0) {
            for stepping-numbers($start - 1, $size - 1) -> @sn {
                take [$start, |(@sn)];
            }
        }

        if ($start != 9) {
            for stepping-numbers($start + 1, $size - 1) -> @sn {
                take [$start, |(@sn)];
            }
        }
    }
}

sub stepping-number-range($start, $end) {
    gather for $start.polymod(100)[1]..$end.polymod(100)[1] -> $i {
        for stepping-numbers($i, 2) -> @sn {
            my $sn = @sn.join('').Int;
            take $sn if ($start <= $sn <= $end);
        }
    }
}

say stepping-number-range(101, 999);
say stepping-number-range(545, 987);
