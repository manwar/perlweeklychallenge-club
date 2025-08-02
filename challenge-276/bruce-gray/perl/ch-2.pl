use v5.40;
use List::Util qw<sum0 pairvalues>;
use Statistics::Frequency;

sub task2 ( $ns_aref ) {
    my $f = Statistics::Frequency->new( $ns_aref );

    my $max = $f->frequencies_max;

    return sum0 grep { $_ == $max } pairvalues $f->frequencies;

    # Without `Statistics::Frequency` module:
    # use List::Util qw<max sum0>;
    # my %bag; $bag{$_}++ for $ns_aref->@*;
    # my $max_count = max values %bag;
    # return sum0 grep { $_ == $max_count } values %bag;
}

my @tests = (
    4, [1, 2, 2, 4, 1, 5],
    5, [1, 2, 3, 4, 5],
);
use Test2::V0 -no_srand => 1; plan @tests/2;
for my ( $expected, $in_array ) (@tests) {
    is task2($in_array), $expected;
}
