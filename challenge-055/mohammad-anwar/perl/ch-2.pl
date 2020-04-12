#!/usr/bin/perl

use strict;
use warnings;

use Algorithm::Combinatorics qw(permutations);

my $N = $ARGV[0] // 4;

my $wave = fetch_wave_array($N);
map { print sprintf("[%s]\n", join(",", @$_)) } @$wave;

sub fetch_wave_array {
    my ($N) = @_;

    die "ERROR: Invalid array size [$N]\n" unless ($N =~ /^\d+$/ && $N > 0);

    my $iter = permutations([ 1..$N ]);
    my $wave = [];
    while (my $array = $iter->next) {
        push @$wave, $array if is_wave($array);
    }

    return $wave;
}

sub is_wave {
    my ($array) = @_;

    my $is_wave = 1;
    foreach my $i (1..$#$array) {
        ($i % 2)
        ?
        ($array->[$i] <= $array->[$i-1])
        :
        ($array->[$i] >= $array->[$i-1])
        and next;

        $is_wave = 0;
        last;
    }

    return $is_wave;
}
