sub f {
    my $c = pop;
    @_ ? ( [ splice @_, 0, $c ], f(@_, $c) ) : ();
}

use Test::More;
is_deeply [ f( 1, 2, 3, 4,   2 ) ] => [ [1, 2], [3, 4]     ];
is_deeply [ f( 1, 2, 3,      3 ) ] => [ [1, 2, 3]          ];
is_deeply [ f( 1, 2, 3, 4,   1 ) ] => [ [1], [2], [3], [4] ];
done_testing;
