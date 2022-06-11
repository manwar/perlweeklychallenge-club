use Modern::Perl;
use experimental qw<signatures>;
use List::Util   qw<sum0 reductions>;

sub eq_index (@list) {
    my @x =         reductions { $a + $b }         @list;
    my @y = reverse reductions { $a + $b } reverse @list;
    return grep { $x[$_] == $y[$_] } keys @x;
}

my @tests = (
    [ [  1,  3,  5,  7,  9         ], [  3,                         ] ],
    [ [  1,  2,  3,  4,  5         ], [                             ] ],
    [ [  2,  4,  2,                ], [  1,                         ] ],
    [ [ -7,  1,  5,  2, -4,  3,  0 ], [  3,  6,                     ] ],
    [ [  2,  4,  6,                ], [                             ] ],
    [ [  2,  9,  2,                ], [  1,                         ] ],
    [ [  1, -1,  1, -1,  1, -1,  1 ], [  0,  1,  2,  3,  4,  5,  6, ] ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my @in  = $_->[0]->@*;
    my @exp = $_->[1]->@*;
    my @got = eq_index(@in);
    is @got, @exp, "eq_index(@in) == @exp";
}
