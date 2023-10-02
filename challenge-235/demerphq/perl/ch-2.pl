use strict;
use warnings;
use Test::More;

sub dupe_zero {
    my ($array) = @_;
    my @ret;
    foreach my $n (@$array) {
        last if (         push(@ret, $n) == @$array )
             or ( !$n and push(@ret, $n) == @$array );
    }
    return \@ret;
}

foreach my $test (
    [ [ 0 ], [ 0 ] ],
    [ [ 1 ], [ 1 ] ],
    [ [ 0, 0, ], [ 0, 0 ] ],
    [ [ 1, 1, ], [ 1, 1 ] ],
    [ [ 0, 0, 1 ], [ 0, 0, 0] ],
    [ [ 1, 0, 2, 3, 0, 4, 5, 0 ], [ 1, 0, 0, 2, 3, 0, 0, 4 ] ],
    [ [ 0, 3, 0, 4, 5 ], [ 0, 0, 3, 0, 0 ] ],
) {
    my ($input, $want) = @$test;
    my $got = dupe_zero($input);
    is("@$got", "@$want", "Test for '@$input'");
}
done_testing();
