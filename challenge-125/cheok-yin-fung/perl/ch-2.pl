#!/usr/bin/perl
# The Weekly Challenge 125
# Task 2: Binary Tree Diameter
# Usage: ch-2.pl [binary tree in array format, 'x' for null nodes]
use strict;
use warnings;
use v5.10.0;
use experimental 'signatures';
use List::Util qw/max/;
use Test::More tests => 3;

# begin: code from Week 113

die <<FOO
Incorrect input format.
Usage: ch-2.pl [binary tree in array format, \'x\' for null nodes]
for example, \$ ch-2.pl 2 3 5 x 7
    2 
   / \\
  3   5
   \\
    7
FOO
    unless defined($ARGV[0]) && consistency(@ARGV);
# end: code from Week 113

my @tree_argv = map { $_ eq 'x' ? undef : $_ } @ARGV;
say "Diameter: ", diameter(\@tree_argv);
say "";


sub diameter {
    my @tree = $_[0]->@*;
    return 0 if scalar @tree == 1;
    my @leaf_id = collect_leaves_by_id(\@tree)->@*;
    my $max_dist = max map {depth($tree[$_])} @leaf_id;
    for my $i (0..$#leaf_id-1) {
        for my $j ($i+1..$#leaf_id) {
            my $dist = path_distance(\@tree, $leaf_id[$i], $leaf_id[$j]);
            $max_dist = $dist if $dist > $max_dist;
        }
    }
    return $max_dist;
}

# above: I am tired this week therefore I don't optimize. -- CY

sub collect_leaves_by_id {
    my @tree = $_[0]->@*;
    my @leaves;
    for my $node_id (0..$#tree) {
        if (defined($tree[$node_id])) {
            push @leaves, $node_id 
              if !defined($tree[$node_id*2+1]) && !defined($tree[$node_id*2+2]);
        }
    }
    return [@leaves];
}

sub path_distance {
    my @tree = $_[0]->@*;
    my ($i1, $i2) = ($_[1], $_[2]);
    return 0 if $i1 == $i2;
    if (defined($tree[$i1]) && defined($tree[$i2])) {
        my $n1 = $i1 < $i2 ? $i1 : $i2;
        my $n2 = $i1 < $i2 ? $i2 : $i1;
        my $d1 = depth($n1);
        my $d2 = depth($n2);
        my $u1 = $n1;
        my $u2 = $n2;
        my $depth_diff = $d2-$d1;
        for (1..$depth_diff) {
            $u2 = int (($u2-1) / 2);
        }

        while ($u1!=$u2) {
            $u1 = int (($u1-1) / 2);
            $u2 = int (($u2-1) / 2);
        }
        my $d_common = depth($u1);
        return $d1+$d2-2*$d_common; 
    }
    else {
        return -1;
    }
}

sub depth ($n) {
    return int (log($n+1) / log 2);
}


ok diameter([2, 3, 5, undef, 7]) == 3, "Tree in Week 113";
ok diameter([1, 2, 5, 3, 4, 6, 7, (undef) x 6, 8, 10, (undef) x 12, 9 ]) == 6,
     "Tree in Example provided";
ok diameter([0..30]) == 8, "a Complete Binary Tree";


# ======== BEGIN: code from Week 113 ===============

sub consistency {
    my @t = @_;
    return 0 if !defined($t[0]) || ($t[0] !~ /^\d+$/ && $t[0] ne 'x');
    for my $ind (1..$#t) { 
        if ($t[$ind] =~ /^\d+$/) {
            if ($t[($ind-1)/2] eq 'x') {
                return 0;
            }
        } 
        elsif ($t[$ind] ne 'x') {
            return 0;
        }
    }
    return 1;
}
# ========== END: code from Week 113 ===============
