#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub invert {
    my ($tree) = @_;
    $_ = [reverse @$_] for values %$tree;
}

sub serialise {
    my ($node, $tree) = @_;
    return $node unless exists $tree->{$node};
    return "$node("
           . join(',', map serialise($_, $tree), @{ $tree->{$node} }) . ')'
}

chomp( my $structure = <DATA> );

my %tree;
while ($structure =~ s/([0-9]+) \( ([0-9]+) , ([0-9]+) \) /$1/x) {
    my ($parent, $left, $right) = ($1, $2, $3);
    $tree{$parent} = [$left, $right];
}

invert(\%tree);

my ($root) = $structure;
say serialise($root, \%tree);

__DATA__
1(2(4,5),3(6,7))
