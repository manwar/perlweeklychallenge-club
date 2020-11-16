#!/usr/bin/env perl6
use v6;

sub rct(@g) {
    my @pairs=((^@g).combinations(2) X (^@g[0]).combinations(2)).grep({ @g[$_[0][0]..$_[0][1];$_[1][0]..$_[1][1]].all == 1 });
    (@pairs) ?? (@pairs.max({ ($_[0][1]-$_[0][0])*($_[1][1]-$_[1][0]) })) !! ()
}

sub displ1(@pair) {
    (! @pair) ?? 0 !! (('1' x (@pair[1][1]-@pair[1][0]+1)) xx ((@pair[0][1]-@pair[0][0]+1))).join("\n")
}

my @g=@*ARGS.map(*.comb.List).List;
say @g.&rct.&displ1;

# run as <script> <space-separated binary strings representing the rows>, e.g. <script> 0010 1001 0111 for the matrix
# [0, 0, 1, 0]
# [1, 0, 0, 1]
# [0, 1, 1, 1]
