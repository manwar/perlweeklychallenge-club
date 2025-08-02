use strict;
use warnings;
use feature 'say';

sub max {
    my $max = shift;
    for (@_) {
        $max = $_ if $_ > $max;
    }
    return $max;
}

sub twice_larger {
    my $largest = max @_;
    my $max_i;
    for my $i (0..$#_){
        my $val = $_[$i];
        if ($val == $largest) {
            $max_i = $i;
            next;
        }
        return -1 if 2 * $val > $largest;
    }
    return $max_i;
}
for my $test ([2, 4, 1, 0], [1, 2, 3, 4], [4, 3, 5, 12, 2]) {
    printf "%-12s => ", "@$test";
    say twice_larger @$test;
}
