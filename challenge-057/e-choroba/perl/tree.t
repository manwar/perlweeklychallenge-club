#!/usr/bin/perl
use warnings;
use strict;

use Tree qw{ from_structure from_edges
             to_structure to_edges to_graph
             invert };

use Test::More;
use Test::Deep;

my @edges = ('4 L 2', '5 R 2', '6 L 3', '7 R 3', '2 L 1', '3 R 1');
my $structure = '1(2(4,5),3(6,7))';

my ($root_e, $tree_e) = from_edges(@edges);
cmp_deeply to_edges($tree_e), bag(map [split], @edges), 'edges';

my ($root_s, $tree_s) = from_structure($structure);
is to_structure($root_s, $tree_s), $structure, 'structure';

is to_structure($root_e, $tree_e), $structure, 'edges to structure';

cmp_deeply to_edges($tree_s), bag(map [split], @edges), 'structure to edges';

my ($root_i, $tree_i) = from_structure($structure);
invert($tree_i);
is to_structure($root_i, $tree_i), '1(3(7,6),2(5,4))', 'invert';

cmp_deeply join("", to_graph($root_e, $tree_e)),
           join("\n", '1-+-2-+-4',
                      '  |   \-5',
                      '  \-3-+-6',
                      '      \-7', ""),
           'graph';

done_testing();
