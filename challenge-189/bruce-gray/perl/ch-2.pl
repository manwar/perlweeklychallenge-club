#!/usr/bin/env perl
use v5.36;
use experimental     qw<for_list builtin>;
use builtin          qw<indexed>;
use List::UtilsBy    qw<max_by min_by>;

# See blog post for shorter code using List::Categorize.
sub task2 ( @a ) {
    my %h;
    for my ($k, $v) (indexed @a) {
        my $href = ( $h{$v} //= {} );

        $href->{KEY  }   = $v;
        $href->{COUNT}  +=  1;
        $href->{FIRST} //= $k;
        $href->{LAST }   = $k;
    }
    $_->{SPAN} = $_->{LAST} - $_->{FIRST} + 1 for values %h;

    my $best = min_by { $_->{FIRST} }
               min_by { $_->{SPAN } }
               max_by { $_->{COUNT} }
               values %h;

   return [ @a[ $best->{FIRST} .. $best->{LAST} ] ];
}


my @tests = (
    # From TWC examples:
    [ [ 1, 3, 3, 2    ] , [ 3, 3       ] ],
    [ [ 1, 2, 1, 3    ] , [ 1, 2, 1    ] ],
    [ [ 1, 3, 2, 1, 2 ] , [ 2, 1, 2    ] ],
    [ [ 1, 1, 2, 3, 2 ] , [ 1, 1       ] ],
    [ [ 2, 1, 2, 1, 1 ] , [ 1, 2, 1, 1 ] ],

    # TWC examples translated to alpha, for easier debugging.
    [ [qw<A C C B  >] , [qw<C C>    ] ],
    [ [qw<A B A C  >] , [qw<A B A>  ] ],
    [ [qw<A C B A B>] , [qw<B A B>  ] ],
    [ [qw<A A B C B>] , [qw<A A>    ] ],
    [ [qw<B A B A A>] , [qw<A B A A>] ],

    # Numeric and alpha versions to stress tie-breaking rules:
    [ [qw<1 1 2 2 2 2 1 1>   ] , [qw<2 2 2 2>] ],
    [ [qw<A A B B B B A A>   ] , [qw<B B B B>] ],
    [ [qw<1 1 1 1 2 2 2 2>   ] , [qw<1 1 1 1>] ],
    [ [qw<A A A A B B B B>   ] , [qw<A A A A>] ],
    [ [qw<1 1 1 1 2 3 2 2 2> ] , [qw<1 1 1 1>] ],
    [ [qw<A A A A B C B B B> ] , [qw<A A A A>] ],

);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ( $in_aref, $expected_aref ) = @{$_};
    is_deeply task2(@{$in_aref}), $expected_aref, "task2(qw<@{$in_aref}>)";
}
