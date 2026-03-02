use Lingua::EN::Numbers qw(num2en); use strict; use warnings; use v5.10;

sub f { #das schwartzian
    map $$_[0],
    sort { $$a[1] cmp $$b[1] }
    map [ $_, num2en($_) ],
    @_
}

my @tests = (
    { Input => [ 6, 7, 8, 9 ,10    ], Output => [ 8, 9, 7, 6, 10    ] },
    { Input => [ -3, 0, 1000, 99   ], Output => [ -3, 99, 1000, 0   ] },
    { Input => [ 1, 2, 3, 4, 5     ], Output => [ 5, 4, 1, 3, 2     ] },
    { Input => [ 0, -1, -2, -3, -4 ], Output => [ -4, -1, -3, -2, 0 ] },
    { Input => [ 100, 101, 102     ], Output => [ 100, 101, 102     ] },
);
say "@{[ f( @{ $$_{Input} } ) ]}" eq "@{[ @{ $$_{Output}} ] }" ? "ok" : "ERROR" for @tests;
