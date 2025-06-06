use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my $result = 0;
    my $n = @ints;
    my $total = 2 ** $n;

    for my $i (0 .. $total - 1) {
        my @set;
        for my $j (0 .. $n - 1) {
            if ($i & (1 << $j)) {
                push @set, $ints[$j];
            }
        }
        if (scalar(@set) > 1) {
            my $intermediate = $set[0];
            for (my $i = 1; $i <= $#set; $i++) {
                $intermediate ^= $set[$i];
            }
            $result += $intermediate;
        } elsif (defined $set[0]) {
            $result += $set[0];
        }
    }
    return $result;
}

is(run(1, 3), 6, "Example 1");
is(run(5, 1, 6), 28, "Example 2");
is(run(3, 4, 5, 6, 7, 8), 480, "Example 3");
