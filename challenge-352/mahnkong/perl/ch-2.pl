use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@nums) {
    my @result;
    for (my $i = 0; $i < scalar(@nums); $i++) {
        my $binary = join('', @nums[0..$i]);
        push @result, oct("0b".$binary) % 5 == 0 ? 1 : 0;
    }
    return [ @result ];
}

is_deeply(
    run(0,1,1,0,0,1,0,1,1,1),
    [1,0,0,0,0,1,1,0,0,0],
    "Example 1"
);

is_deeply(
    run(1,0,1,0,1,0),
    [0,0,1,1,0,0],
    "Example 2"
);

is_deeply(
    run(0,0,1,0,1),
    [1,1,0,0,1],
    "Example 3"
);

is_deeply(
    run(1,1,1,1,1),
    [0,0,0,1,0],
    "Example 4"
);

is_deeply(
    run(1,0,1,1,0,1,0,0,1,1),
    [0,0,1,0,0,1,1,1,0,0],
    "Example 5"
);
