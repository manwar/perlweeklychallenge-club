use strict;
use warnings;
use 5.020;
use experimental qw<signatures>;
use List::Util   qw<sum0>;
use ntheory      qw<forcomb>;

sub set_difference ( $x, $y ) {
    my %h;
    $h{$_}++ for @{$x};
    $h{$_}-- for @{$y};
    return [ grep { $h{$_}-- > 0 } @{$x} ];
}

sub tug_of_war ( $s ) {
    my @s = @{$s};
    my $size   = int(@s / 2);
    my $target = sum0(@s) / 2;

    my $best_cost = $target * 2;
    my @best_list;
    forcomb {
        my $cost = abs sum0(@s[@_]) - $target;
        if ($best_cost > $cost) {
            $best_cost = $cost;
            @best_list = @s[@_];
        }
    } @s, $size;

    return \@best_list, set_difference( \@s, \@best_list );
}

my @tests = (
    [10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
    [10, -15, 20, 30, -25, 0, 5, 40, -5],

    # Needed tests with duplicate numbers
    [10, 20, 30, 40, 50, 60, 70, 80, 90, 100,  99,99,99,99,99,99],
    [10, -15, 20, 30, -25, 0, 5, 40, -5,       99,99,99,99,99,99],
);

for (@tests) {
    say join ' ', map { '(' . join(' ', @{$_}) . ')'} tug_of_war($_);
}
