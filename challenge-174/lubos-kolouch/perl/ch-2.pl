package main;
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);
use Data::Dumper;

sub permutation2rank {
    my ( $list, $what ) = @_;

    my @all_permutations = permutations($list);

    my $pos = 0;
    for my $comb (@all_permutations) {
        return $pos if $comb ~~ @$what;
        $pos++;
    }

    return -1;
}

sub rank2permutation {
    my ( $list, $what ) = @_;

    my @all_permutations = permutations($list);

    return $all_permutations[$what];
}

use Test::More;

my @list = ( 0, 1, 2 );
my @test = ( 1, 0, 2 );
is( permutation2rank( \@list, \@test ), 2 );

is_deeply( rank2permutation( \@list, 1 ), [ 0, 2, 1 ] );
done_testing;
1;
