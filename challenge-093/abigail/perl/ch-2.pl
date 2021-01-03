#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

my $LEFT  = 0;
my $NODE  = 1;
my $RIGHT = 2;

#
# Recursively calculate the "tree sum". sum_tree returns a tuple:
#    - $sum:   The sum tree of the tree
#    - $paths: The number of possible paths
#
sub sum_tree ($tree) {
    return (0, 0) unless @$tree;  # Empty tree

    #
    # Recurse
    #
    my ($s_l, $p_l) = sum_tree ($$tree [$LEFT]);
    my ($s_r, $p_r) = sum_tree ($$tree [$RIGHT]);

    #
    # The number of paths is the sum of the number of paths of each
    # child, or 1 if both childs are empty.
    # The sum is the sum of the tree sums of both children, plus the
    # value of the node itself, times the number of paths.
    #
    my $paths = ($p_l + $p_r) || 1;
    my $sum   =  $s_l + $s_r + $paths * $$tree [$NODE];

    ($sum, $paths);
}

#
# Did not want to parse the input, as two examples are not enough
# to deduce how the input looks like -- for instance, if we have
# a root with two children, which each has two children, how is
# it going to look? 
#
# So, we're just hard coding the two examples. Blech.
#

my $leaf = [];

#
# Tree from example 1
#
my $t1_3 = [$leaf, 3, $leaf];
my $t1_4 = [$leaf, 4, $leaf];
my $t1_2 = [$t1_3, 2, $t1_4];
my $t1_1 = [$t1_2, 1, $leaf];

#
# Tree from example 2
#
my $t2_4 = [$leaf, 4, $leaf];
my $t2_2 = [$t2_4, 2, $leaf];
my $t2_5 = [$leaf, 5, $leaf];
my $t2_6 = [$leaf, 6, $leaf];
my $t2_3 = [$t2_5, 3, $t2_6];
my $t2_1 = [$t2_2, 1, $t2_3];

say +(sum_tree $t1_1) [0];
say +(sum_tree $t2_1) [0];

__END__
