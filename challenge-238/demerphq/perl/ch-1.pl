use strict;
use warnings;

sub running_sum {
    my ($array) = @_;
    my @sum;
    $sum[0] = $array->[0];
    for(my $i = 1; $i < @$array; $i++) {
        $sum[$i] = $array->[$i] + $sum[$i-1];
    }
    return \@sum;
}

use Test::More;

foreach my $tuple (
    [[1, 2, 3, 4, 5], [1, 3, 6, 10, 15]],
    [[1, 1, 1, 1, 1], [1, 2, 3, 4, 5]],
    [[0, -1, 1, 2],   [0, -1, 0, 2]],
) {
    my ($input, $want) = @$tuple;
    my $got = running_sum($input);
    is( "@$got", "@$want", "Test [@$input]");
}
done_testing();
__END__
