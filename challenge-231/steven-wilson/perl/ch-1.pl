#!/usr/bin/env perl

use 5.12.0;
use Test2::V0 -no_srand;
use List::Util qw/ min max /;

is( pluck_min_max( ( 3, 2, 1, 4 ) ),
    array {
        item 3;
        item 2;
    },
    "Example 1"
);
is( pluck_min_max( ( 3, 1 ) ), -1, "Example 2" );
is( pluck_min_max( ( 2, 1, 3 ) ),
    array {
        item 2;
    },
    "Example 3"
);
done_testing();

sub pluck_min_max {
    my @elements = @_;
    return -1 if ( scalar @elements < 3 );
    my $min      = min @elements;
    my $max      = max @elements;
    my @result   = grep { !( ( $min == $_ ) || ( $max == $_ ) ) } @elements;
    return \@result;
}
