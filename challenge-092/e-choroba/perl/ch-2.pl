#!/usr/bin/perl
use warnings;
use strict;

use FindBin;

# We've already solved the challenge in week 50. Load the code from
# the challenge, but skip its tests.
BEGIN {
    $INC{'Test/More.pm'} = 1;
    sub is_deeply {}
}
do "$FindBin::Bin/../../../challenge-050/e-choroba/perl/ch-1.pl";

sub insert_interval {
    my ($intervals, $new) = @_;
    my $skip = 'MyInterval'->new;
    $skip->insert(@$_) for @$intervals, $new;
    return $skip->out
}

# Now, enable testing again so we can test the solution.
delete $INC{'Test/More.pm'};
require Test::More;
'Test::More'->import(tests => 3 + 2);

is_deeply insert_interval([[1, 4], [8, 10]], [2, 6]),
    [[1, 6], [8, 10]], 'Example 1';
is_deeply insert_interval([[1, 2], [3, 7], [8, 10]], [5, 8]),
    [[1, 2], [3, 10]], 'Example 2';
is_deeply insert_interval([[1, 5], [7, 9]], [10, 11]),
    [[1, 5], [7, 9], [10, 11]], 'Example 3';

is_deeply insert_interval([[3, 5], [7, 9]], [1, 2]),
    [[1, 2], [3, 5], [7, 9]], 'Insert first';
is_deeply insert_interval([[2, 3], [4, 5], [7, 9]], [1, 10]),
    [[1, 10]], 'Merge all';
