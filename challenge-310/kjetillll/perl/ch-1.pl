sub f {
    my @arr = @_;
    my %elem;
    for my $i ( 0 .. $#arr ){
        $elem{$_}{$i}++ for @{ $arr[$i] };
    }
    sort{ $a <=> $b } grep @_ == keys %{ $elem{$_} }, keys %elem
}

use Test::More tests => 3;
is_deeply [ f( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] ) ], [1, 4];
is_deeply [ f( [1, 0, 2, 3], [2, 4, 5] )                  ], [2];
is_deeply [ f( [1, 2, 3], [4, 5], [6] )                   ], [];
