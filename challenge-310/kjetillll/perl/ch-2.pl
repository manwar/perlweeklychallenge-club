
sub f {
    my(@even, @odd);
    push @{ [\@even, \@odd]->[$_ % 2] }, $_[ $_ ] for 0 .. $#_;
    @$_ = sort { $a <=> $b } @$_ for \@even, \@odd;
    map @odd ? ($_, pop @odd) : ($_), @even
}

use Test::More tests => 3;
is_deeply [ f( @{ $$_[0] } ) ], $$_[1] for
[ [4, 1, 2, 3]    => [2, 3, 4, 1]     ],
[ [3, 1]          => [3, 1]           ],
[ [5, 3, 2, 1, 4] => [2, 3, 4, 1, 5]  ];
