use v5.38;
use List::Util qw( uniq );

sub no_seq(@ints) {
    for my $i (0 .. $#ints - 1) {
        for my $j ($i + 1 .. $#ints) {
            return 0 if (abs($ints[$i] - $ints[$j]) == 1);
        }
    }
    return 1;
}

sub proc(@ints) {
    say "Input: \@ints = @ints";
    @ints = uniq(@ints);
    return -1 if (no_seq(@ints) == 1);
    my $len = 1;
    my @chain;
    for my $i (0 .. $#ints) {
        for my $j (0 .. $#ints) {
            next if ($i == $j);
            if (abs($ints[$i] - $ints[$j]) == 1) {
                push @chain, $ints[$i];
                last;
            }
        }
    }
    @chain = sort @chain;
    return scalar @chain;
}

my @ints = (10, 4, 20, 1, 3, 2);
say "Output: ", proc(@ints);
@ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7);
say "Output: ", proc(@ints);
@ints = (10,30,20);
say "Output: ", proc(@ints);
