use strict;
use warnings;
use Test::More;

sub check_array {
    my ($array) = @_;

    my $out_of_order = 0;
    my $last = $array->[0];

    for (my $i = 1; $i <= $#$array; $i++) {
        # there are two cases (the last element is redundant here):
        # A: 3, 10, 4, 5       -> drop the 10
        # B: 3, 10, 1, 11      -> drop the 1
        my $this = $array->[$i];
        if ($last > $this) {
            $out_of_order++ and return 0;
            if ($i > 1 and $array->[$i-2] > $array->[$i]) {
                $this = $array->[$i-1];
            }
        }
        $last = $this;
    }
    return 1;
}

foreach my $test (
    [ 1, [ 0, 2, 9, 4, 10, 11 ] ],
    [ 1, [ 0, 2, 9, 4, 6 ] ],
    [ 0, [ 5, 1, 3, 2] ],
    [ 1, [ 2, 2, 3 ] ],
    [ 1, [ 1, 2, 3 ] ],
    [ 0, [ 1, 2, 3, 2, 1 ] ],
    [ 0, [ 1, 2, 3, 3, 3, 1, 2, 3 ] ],
    [ 0, [ 1, 2, 3, 1, 2, 3 ] ],
    [ 0, [ 1, 2, 3, 2, 3, 2 ] ],
    [ 1, [ 1, 2, 3, 10, 1, 11, 12, 13 ] ],
    [ 0, [ 1, 2, 3, 10, 1, 11, 4, 13 ] ],
) {
    my ($want, $array)= @$test;
    my $got = check_array($array) ? 1 : 0;
    is($got, $want, "Test @$array: want $want");
}
done_testing();
