#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

sub children { my $i = shift; 2*$i+1, 2*$i+2 }
sub parent { my $i = shift; ($i-1)/2; }  # not needed here

sub display {
    my $bft_tree = bft(shift);
    my $start = scalar @{$bft_tree->[-1]};
    my $sep_val = (2 * $start) - 1;
    for my $line (@$bft_tree) {
        my $sep = " " x $sep_val;
        say " " x $start, join $sep, @$line;
        $start /= 2;
        $sep_val = ($sep_val - 1) / 2;
    }
}
sub bft {               # Breadth First Traversal
    my $tree = shift;
    my ($index, $level) = (0, 0);
    my @bft_tree;
    while ($index < scalar @$tree) {
        my $new_index = $index + 2 ** $level - 1;
        push @{$bft_tree[$level++]}, @{$tree}[$index .. $new_index];
        $index = $new_index + 1;
    }
    return \@bft_tree;
}

my $tree = [ 1..7 ];
say "\nTree before change:";
display $tree;
my $sum = 0;
$sum += $_ for @$tree;
my $new_tree = [ map $sum - $_, @$tree ];
say "\nNew tree";
display $new_tree;
