use strict;
use warnings;

sub highest_value {
    my @nums = @_;
    @nums = sort { $b . $a cmp $a . $b } @nums;
    return join '', @nums;
}

print highest_value(1, 23), "\n";
print highest_value(10, 3, 2), "\n";
print highest_value(31, 2, 4, 10), "\n";
print highest_value(5, 11, 4, 1, 2), "\n";
print highest_value(1, 10), "\n";

