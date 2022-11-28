use v5.36;
use List::Util qw<sum0 reductions>;
sub functional ( @a ) {
    my $s = sum0 @a;

    return -1 if $s % @a;
    my $target = $s / @a;

    return sum0 map         { abs $_ }
                reductions  { $a + $b }
                map         { $_ - $target }
                @a;
}
sub task2 ( @a ) {
    return -1 if sum0(@a) % scalar(@a);
    my $target = sum0(@a) / scalar(@a);

    my ($count, $mound) = 0, 0;
    for my $n (@a) {
        $mound += $n - $target;
        $count += abs $mound;
    }

    die "Cannot happen: $mound" unless $mound == 0;

    return $count;
}

my @tests = (
    # Examples from task:
    [ [1, 0, 5],  4 ],
    [ [0, 2, 0], -1 ],
    [ [0, 3, 0],  2 ],

    # Invented:
    [ [4,0,0,0], 6],
    [ [3,1,0,0], 5],
    [ [3,0,1,0], 4],
    [ [3,0,0,1], 3],
    [ [2,2,0,0], 4],
    [ [2,0,2,0], 2],
    [ [2,0,0,2], 2],
    [ [2,1,1,0], 3],
    [ [2,1,0,1], 2],
    [ [2,0,1,1], 1],
    [ [1,1,1,1], 0],
    [ [1,2,1,0], 2],
    [ [1,2,0,1], 1],
    [ [1,1,2,0], 1],
    [ [1,1,0,2], 1],

    [ [2+(8*1000), 2, 2, 2, 2, 2, 2, 2], 1000*sum0(1..7) ],
    [ [2, 2, 2, 2, 2, 2, 2, 2+(8*1000)], 1000*sum0(1..7) ],
    [ [2, 2, 2, 2, 2, 2, 2+(8*1000), 2], 1000*sum0(1..6, 1) ],

    [ [6,3,3,3,3,0,3,3,3,3,0,1,3,3,3,6,5], 15+15+10], # For the blog post
);

use Test::More;
plan tests => 2*@tests;
for (@tests) {
    my ( $in_aref, $expected ) = @{$_};
    is task2(@{$in_aref}), $expected;
    is functional(@{$in_aref}), $expected;
}
