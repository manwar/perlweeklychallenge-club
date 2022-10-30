# The Weekly Challenge 188
# Task 2 Total Zero
#
# Comment: Actually I don't very get how the operations run.

use v5.30.0;

sub total_zero {
    my $t = 0;
    my $x = $_[0];
    my $y = $_[1];
    while ($x != 0) {
        if ($x >= $y) {
            $x = $x - $y;
        }
        else {
            $y = $y - $x;
        }
        $t++;
    }
    return $t;
}

use Test::More tests=>6;
ok total_zero(5,4) == 5;
ok total_zero(4,6) == 3;
ok total_zero(2,5) == 4;
ok total_zero(3,1) == 3;
ok total_zero(7,4) == 5;
ok total_zero(2,2) == 1;
