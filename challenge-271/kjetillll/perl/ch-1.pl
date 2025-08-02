use List::Util 'reduce'; use Test::More tests=>4; use strict; use warnings;

sub maximum_ones {
    my $row=0;
    (
        reduce {
            $row++;
            $b > $$a[0] ? [$b,$row] : $a
        }
        [-1,0],
        map { 0 + grep $_==1, @$_ }
        @{ pop() }
    )
    ->[ 1 ]
}

is maximum_ones( $$_{matrix} ), $$_{output}
    for { matrix => [ [0, 1],
                      [1, 0] ],    output => 1 },
        { matrix => [ [0, 0, 0],
                      [1, 0, 1] ], output => 2 },
        { matrix => [ [0, 0],
                      [1, 1],
                      [0, 0] ],    output => 2 },
        { matrix => [ [0, 0, 1],
                      [0, 1, 0],
                      [1, 1, 1],
                      [1, 1, 1],
                      [1, 0, 1] ], output => 3 };
