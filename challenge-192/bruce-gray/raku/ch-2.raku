# Because I still have 60-characters-worth of residual evil left over from Halloween:
sub golfed(@a){(@a.sum!%%+@a)??-1!!([\+](@a X-(@a.sum div+@a)))».abs.sum}

sub task2 ( @a --> Int ) {
    return -1 if @a.sum !%% +@a;

    my $target = @a.sum div @a.elems;

    my ($count, $mound) = 0, 0;
    for @a -> $a {
        $mound += $a - $target;
        $count += $mound.abs;
    }

    die "Cannot happen: $mound" unless $mound == 0;

    return $count;
}

my @tests =
    # Examples from task:
    ( (1, 0, 5),  4 ),
    ( (0, 2, 0), -1 ),
    ( (0, 3, 0),  2 ),

    # Invented:
    ( (4,0,0,0), 6),
    ( (3,1,0,0), 5),
    ( (3,0,1,0), 4),
    ( (3,0,0,1), 3),
    ( (2,2,0,0), 4),
    ( (2,0,2,0), 2),
    ( (2,0,0,2), 2),
    ( (2,1,1,0), 3),
    ( (2,1,0,1), 2),
    ( (2,0,1,1), 1),
    ( (1,1,1,1), 0),
    ( (1,2,1,0), 2),
    ( (1,2,0,1), 1),
    ( (1,1,2,0), 1),
    ( (1,1,0,2), 1),

    ( (2+(8*1000), 2, 2, 2, 2, 2, 2, 2), 1000*(1..7).sum ),
    ( (2, 2, 2, 2, 2, 2, 2, 2+(8*1000)), 1000*(1..7).sum ),
    ( (2, 2, 2, 2, 2, 2, 2+(8*1000), 2), 1000*(|(1..6),1).sum ),
    ( (6,3,3,3,3,0,3,3,3,3,0,1,3,3,3,6,5), 15+15+10), # For the blog post
;

use Test;
plan 2*@tests;
for @tests -> ( $in, $expected ) {
    is  task2($in), $expected;
    is golfed($in), $expected;
}
