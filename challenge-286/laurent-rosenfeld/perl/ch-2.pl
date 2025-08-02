use strict;
use warnings;
use feature 'say';

sub max { $_[0] > $_[1] ? $_[0] : $_[1]; }

sub min { $_[0] > $_[1] ? $_[1] : $_[0]; }

sub order_game {
    my $min = 1;
    my @in = @_;
    while (1) {
        my ($i, $j) = (shift, shift);
        push @_, $min ? min($i, $j) : max $i, $j;
        $min = not $min;
        return $_[0] if @_ == 1;
    }
}

my @tests = ([2, 1, 4, 5, 6, 3, 0, 2], [0, 5, 3, 2],
            [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]);
for my $test (@tests) {
    printf "%-8s ... => ", "@$test[0..3]";
    say order_game @$test;
}
