sub f_straightforward {
    my($x, @seen, @ans) = (0);
    for( @_ ){
        if ( $_ >= 0 ) {
            unshift @seen, $_;
            $x = 0;
        }
        else {
            push @ans, $x < @seen ? $seen[$x] : -1;
            $x++
        }
    }
    @ans
}

sub f_kinda_functional {
    my($x, @seen) = (0);
    grep defined, map $_ > 0 && [$x=0, unshift @seen, $_] ? undef : $x++ < @seen ? $seen[$x-1] : -1, @_
}

use Test::More tests => 2 * 5;
for my $f ( \&f_straightforward, \&f_kinda_functional ){
    is_deeply [ &$f(5, -1, -1)              ],  [ 5, -1      ];
    is_deeply [ &$f(3, 7, -1, -1, -1)       ],  [ 7, 3, -1   ];
    is_deeply [ &$f(2, -1, 4, -1, -1)       ],  [ 2, 4, 2    ];
    is_deeply [ &$f(10, 20, -1, 30, -1, -1) ],  [ 20, 30, 20 ];
    is_deeply [ &$f(-1, -1, 5, -1)          ],  [ -1, -1, 5  ];
}
