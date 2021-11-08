#!/usr/bin/env raku

use Test;
plan 3;

is largest-multiple(<1 0 2 6>), 6210;
is largest-multiple(<1 4 2 8>), 8412;
is largest-multiple(<4 1 7 6>), 7614;

sub largest-multiple(@nums is copy)
{
    @nums .= sort({ $^b <=> $^a });
    my $i  = @nums.first(* %% 2, :end, :k);

    if $i 
    {
        my $tail = @nums.splice($i, 1);
        return @nums.join ~ $tail;
    }

    return q{};
}
