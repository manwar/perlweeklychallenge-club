use strict; use warnings; use Test::More;

sub merge_items {
    my %idsum;
    $idsum{ $$_[0] } += $$_[1] for map @$_, @_;
    [ map [ $_, $idsum{$_} ], sort {$a<=>$b} keys %idsum ]
}

my @tests = (
    {
	items1 => [ [1,1], [2,1], [3,2] ],
	items2 => [ [2,2], [1,3] ],
        want   => [ [1,4], [2,3], [3,2] ]
    },
    {
	items1 => [ [1,2], [2,3], [1,3], [3,2] ],
	items2 => [ [3,1], [1,3] ],
        want   => [ [1,8], [2,3], [3,3] ]
    },
    {
	items1 => [ [1,1], [2,2], [3,3] ],
	items2 => [ [2,3], [2,4] ],
        want   => [ [1,1], [2,9], [3,3] ]
    }
);
for my $test (@tests) {
    my $got = merge_items( @$test{'items1', 'items2'} );
    is_deeply( $got, $$test{want} );
}
done_testing;
