#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Syntax::Construct qw{ // };

sub fill_sum {
    _fill_sum($_[0], 0, [], my $path_sums = {});
    return $path_sums
}

sub _fill_sum {
    my ($tree, $parent_sum, $parent_path, $path_sums) = @_;
    $tree->{s} = $tree->{v} + ($parent_sum // 0);
    $tree->{p} = [ @$parent_path, $tree->{v} ];
    if ($tree->{ch}) {
        _fill_sum($_, $tree->{s}, $tree->{p}, $path_sums) for @{ $tree->{ch} };
    } else {
        push @{ $path_sums->{ $tree->{s} } }, $tree->{p};
    }
}

my $tree = {
    v => 5, ch => [
        { v => 4, ch => [
            { v => 11, ch => [
                { v => 7 },
                { v => 2 }
            ] }
        ] },
        { v => 8, ch => [
            { v => 13 },
            { v => 9, ch => [
                { v => 1 }
            ] }
        ] }
    ] };
my $sum = 22;


my $path_sums = fill_sum($tree);
say join '->', @$_ for @{ $path_sums->{$sum} // [] };
