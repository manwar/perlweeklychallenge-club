#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <space-separated strings>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::AllUtils qw(any);

sub others($ix,$arr) {
    my @others = $arr->@[ grep {$_ != $ix} keys @{$arr}];
    return \@others;
}

sub canChain($words,$start,$end) {
    (! scalar @{$words}) && return 0;
    scalar @{$words} == 1 && do {
	return 0+(substr($words->[0],0,1) eq $start && substr($words->[0],-1) eq $end);
    };
    my @startIdxs = grep { substr($words->[$_],0,1) eq $start } keys @{$words};    
    return 0+(any { canChain(others($_,$words),substr($words->[$_],-1),$end) } @startIdxs);
}

say((scalar @ARGV < 2) ? (0) : (0+(canChain(others(0,\@ARGV),substr($ARGV[0],-1),substr($ARGV[0],0,1)))));
