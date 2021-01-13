#!/usr/bin/perl
use warnings;
use strict;

use FindBin;
use lib $FindBin::Bin;
use Tree qw{ to_graph from_structure from_edges };

for my $g ('1(2,3)',
           '1(200(4(8(16,17),9),5(10,11)),3(6(12,13),7(14,15)))',
           '10(200(4,50000),300000(6000000,700))',
) {
    print to_graph(from_structure($g));
}

print to_graph(from_edges(
    '2 L 1', '3 R 1', '4 L 2', '5 R 2', '6 L 3', '7 R 3'));
