# Test: perl6 ./ch2.p6
use v6.d;

sub MAIN () {
    my @list = (10, 4, 1, 8, 12, 3);
    my @indices = (0, 2, 5);

    my @sublist = @list[@indices].sort;

    # Override the original array
    my $i = 0;
    for (@indices) -> $index {
        @list[$index] = @sublist[$i++];
    }

    say @list;
}
