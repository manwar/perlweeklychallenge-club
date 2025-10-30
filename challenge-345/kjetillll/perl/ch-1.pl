sub peaks {
    grep { ( $_[$_-1] // -Inf ) < $_[$_] > ( $_[$_+1] // -Inf ) } 0 .. $#_
}
use Test::More tests => 5;
is_deeply [ peaks(1, 3, 2)             ],  [1];
is_deeply [ peaks(2, 4, 6, 5, 3)       ],  [2];
is_deeply [ peaks(1, 2, 3, 2, 4, 1)    ],  [2, 4];
is_deeply [ peaks(5, 3, 1)             ],  [0];
is_deeply [ peaks(1, 5, 1, 5, 1, 5, 1) ],  [1, 3, 5];
