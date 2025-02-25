use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub get_largest_int($ints_ref, $not_larger_than = undef) {
    my $largest = {};
    for (my $i = 0; $i <= $#$ints_ref; $i++) {
        if (!exists($largest->{value}) || ($ints_ref->[$i] > $largest->{value} && (! defined $not_larger_than || $ints_ref->[$i] < $not_larger_than))) {
            $largest->{value} = $ints_ref->[$i];
            $largest->{index} = $i;
        }
    }
    return $largest;
}

sub run(@ints) {
    while (scalar(@ints) > 1) {
        my @new;
        my $l1 = get_largest_int(\@ints);
        my $l2 = get_largest_int(\@ints, $l1->{value});
        my ($x, $y) = $l1->{index} < $l2->{index} ? ($l1->{value}, $l2->{value}) : ($l2->{value}, $l1->{value});

        foreach my $i (@ints) {
            if ($i != $x) {
                push @new, $i == $y ? $y - $x : $i;
            }
        }
        @ints = @new;
    }
    return scalar(@ints) > 0 ? $ints[$#ints] : 0;
}

is(run(3, 8, 5, 2, 9, 2), 1, "Example 1");
is(run(3, 2, 5), 0, "Example 2");
