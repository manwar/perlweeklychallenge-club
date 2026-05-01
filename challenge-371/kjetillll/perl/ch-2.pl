use List::Util 'sum';
use Algorithm::Combinatorics 'subsets';

sub f_almost_readable {
    map [ map $$_{element}, @$_ ],
    grep sum( map $$_{index}, @$_ )
      == sum( map $$_{element}, @$_ ),
    grep 1 < @$_ < @_,
    subsets [ map { { index => $_, element => $_[ $_ - 1 ] } } 1 .. @_ ];
}

#same golfed:
sub f{map[map$_[$_-1],@$_],grep sum(@$_)==sum(map$_[$_-1],@$_),grep@_>@$_>1,subsets[1..@_]}



use Test::More;
is_deeply_any_order( [ f( 2, 1, 4, 3) ],     [ [2, 1], [1, 4], [4, 3], [2, 3] ] );
is_deeply_any_order( [ f( 3, 0, 3, 0) ],     [ [3, 0], [3, 0, 3]              ] );
is_deeply_any_order( [ f( 5, 1, 1, 1) ],     [ [5, 1, 1]                      ] );
is_deeply_any_order( [ f( 3, -1, 4, 2) ],    [ [3, 2], [3, -1, 4]             ] );
is_deeply_any_order( [ f( 10, 20, 30, 40) ], [                                ] );
done_testing;
sub is_deeply_any_order { #maybe use Test::Deep
    my($got, $exp) = map [sort { @$a <=> @$b || $$a[0]<=>$$b[0] || $$a[1]<=>$$b[1] } @$_ ], @_; #hm
    is_deeply($got, $exp);
}

