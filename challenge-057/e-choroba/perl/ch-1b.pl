#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub invert {
    my ($node, $tree) = @_;
    return $node unless exists $tree->{$node};

    my @ch = reverse @{ $tree->{$node} };
    return $node . '(' . join(',', map invert($_, $tree), @ch) . ')'
}

chomp( my $structure = <DATA> );

my %tree;
while ($structure =~ s/([0-9]+) \( ([0-9]+) , ([0-9]+) \) /$1/x) {
    my ($parent, $left, $right) = ($1, $2, $3);
    $tree{$parent} = [$left, $right];
}

my ($root) = $structure =~ /[0-9]+/;
say '(', invert($root, \%tree), ')';

__DATA__
(1(2(4,5),3(6,7)))
