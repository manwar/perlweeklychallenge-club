#!/bin/env raku

unit sub MAIN(*@binary where @binary.all == 0|1);

put (^+@binary).combinations(2).map({ contiguous-subarray-size(|$_) }).max;

sub contiguous-subarray-size(UInt:D \begin, UInt:D \end --> UInt:D) {
    with end - begin + 1 -> \len {
        begin < end && len %% 2 && @binary[begin..end].sum * 2 == len ?? len !! 0
    }
}
