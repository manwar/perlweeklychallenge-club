#!/usr/bin/env perl

use v5.38;

sub sort_language ( $lang, @positions ) {
    my %pos_map;
    @pos_map{@positions} = @{$lang};
    my @res = @pos_map{ sort @positions };
    return \@res;
}

sub MAIN() {

    #| Run test cases
    use Test2::V0 qw( is plan );
    plan 2;

    is sort_language( [ 'perl', 'c', 'python' ], 2, 1, 3 ),
      [ 'c', 'perl', 'python' ],
      "works for ('c', 'perl', 'python')";
    is sort_language( [ 'c++', 'haskell', 'java' ], 1, 3, 2 ),
      [ 'c++', 'java', 'haskell' ],
      "works for ('c++', 'java', 'haskell')";
}

MAIN();
