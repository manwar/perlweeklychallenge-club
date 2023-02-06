use strict;
use warnings;
use feature "say";

sub three_odd {
    my $count = 0;
    for my $n (@_) {
        if ($n % 2) {     # Odd
            $count++;
        } else {          # Even
            $count = 0;
        }
        return 1 if $count >= 3;
    }
    return 0;
}

for my $test ([<1 5 3 6>], [<2 6 3 5>],
              [<1 2 3 4>], [<2 3 5 7>]) {
    say "@$test => ", three_odd @$test;
}
