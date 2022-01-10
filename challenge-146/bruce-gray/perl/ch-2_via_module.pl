#!/usr/bin/env perl
use Modern::Perl;
use experimental qw<signatures>;
use File::Slurp;
use Test::More;

use Math::PlanePath::RationalsTree;
use constant CW => Math::PlanePath::RationalsTree->new( tree_type => 'CW' );
# Note: Due to the use of `n` in the ::RationalsTree module (position vs navigation),
# this version of the code is only reliable below level 64 of the tree on 64-bit Perl.
# On my machine, this code fails 36 of the 202 tests.
sub task2 ( $s ) {
    $s =~ m{ \A (\d+) / (\d+) \z }msx
        or die;

    my $parent = CW->tree_n_parent( CW->xy_to_n($1, $2) );
    my $grand  = CW->tree_n_parent( $parent );

    return map { join "/", CW->n_to_xy($_) } $parent, $grand;
}

# Below here is identical to this section of ch-2.pl
sub run_test_suite ( ) {
    my @tests = map { /\S/ ? [split] : ()    }
                map { s{ \s* \# .* $ }{}msxr }
                read_file './Test_data/ch-2_tests.txt';

    plan tests => 0+@tests;

    for (@tests) {
        die if @{$_} != 3;
        my ( $in, $exp1, $exp2 ) = @{$_};
        my ( $got1, $got2 ) = task2($in);

        is_deeply [$got1, $got2], [$exp1, $exp2], "task2($in) == $exp1, $exp2";
    }
}

if (@ARGV) {
    say "$_ has CW parent,grandparent : ", join ',', task2($_) for @ARGV;
}
else {
    run_test_suite();
}
