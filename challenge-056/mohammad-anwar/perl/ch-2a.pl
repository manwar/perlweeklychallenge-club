#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

=head1 TREE

              5
             / \
            4   8
           /   / \
          11  13  9
         /  \      \
        7    2      1

=cut

my $unit_tests = {
    22 => {
            5 => { 4 => { 11 => [7, 2] },
                   8 => { 13 => [],
                           9 => [1],
                        },
                 },
          },
};

foreach my $sum (keys %$unit_tests) {
    is_deeply (find_matched_paths($unit_tests->{$sum}, $sum), ["5 -> 4 -> 11 -> 2"]);
}

done_testing;

sub find_matched_paths {
    my ($TREE, $SUM) = @_;

    my $paths = [];
    foreach my $k (keys %$TREE) {
        my $path = [ $k+0 ];
        foreach my $i (keys %{$TREE->{$k}}) {
            my $_path = [ $k, $i+0 ];
            foreach my $j (keys %{$TREE->{$k}->{$i}}) {
                push @$_path, $j+0;
                if (scalar(@{$TREE->{$k}->{$i}->{$j}})) {
                    foreach (@{$TREE->{$k}->{$i}->{$j}}) {
                        push @$paths, [ @$_path, $_+0 ];
                    }
                }
                else {
                    push @$paths, [ @$_path ];
                }
            }
        }
    }

    my $matched_paths = [];
    foreach my $path (@$paths) {
        my $total = 0;
        $total += $_ foreach @$path;
        push @$matched_paths, join(" -> ", @$path) if ($total == $SUM);
    }

    return $matched_paths;
}
