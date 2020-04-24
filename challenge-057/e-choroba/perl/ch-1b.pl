#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use ARGV::OrDATA;

use FindBin;
use lib $FindBin::Bin;
use Tree qw{ from_structure };

sub invert {
    my ($node, $tree) = @_;
    return $node unless exists $tree->{$node};

    my @ch = reverse @{ $tree->{$node} };
    return $node . '(' . join(',', map invert($_, $tree), @ch) . ')'
}

chomp( my $structure = <> );
my ($root, $tree) = from_structure($structure);
say '(', invert($root, $tree), ')';

__DATA__
(1(2(4,5),3(6,7)))
