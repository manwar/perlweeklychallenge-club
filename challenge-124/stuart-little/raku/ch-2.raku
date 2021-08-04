#!/usr/bin/env raku
use v6;

# run <script> <space-separated numbers>

sub splt(@set) {
    my $sm = @set.sum;
    my @low = @set.combinations(@set.elems div 2).grep({ 2*$_.sum <= $sm }).max({ $_.sum }).Array;
    my @high = (@set (-) @low).keys;
    return @low, @high;
}

my @nums = (@*ARGS.elems %% 2) ?? (@*ARGS.map(*.Num)) !! ([0,|@*ARGS.map(*.Num)]);
my ($low, $high) = @nums.&splt;
(2*$low.elems > @*ARGS.elems && $low.grep({ $_ == 0}).elems) && do {
    $low = ($low (-) (0)).keys.Array;
} || (2*$high.elems > @*ARGS.elems && $high.grep({ $_ == 0}).elems) && do {
    $high = ($high (-) (0)).keys.Array;
}

say $low;
say $high;
