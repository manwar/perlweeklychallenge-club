#!/usr/bin/env perl6
use v6;

# run <script> <space-separated strings>

sub canChain(@words,$start,$end) {
    (! @words.elems) && return 0;
    @words.elems == 1 && do {
	return (@words[0].substr(0,1) eq $start && @words[0].substr(*-1) eq $end).Int;
    };
    my @startIdxs = @words.keys.grep({ @words[$_].substr(0,1) eq $start });
    return @startIdxs.map({ canChain(@words[(@words.keys (-) $_).keys.sort], substr(@words[$_],*-1), $end) }).any.Bool.Int;
}

((@*ARGS.elems < 2) ?? (0) !! (canChain(@*ARGS[1..*],substr(@*ARGS[0],*-1),substr(@*ARGS[0],0,1)))).say;
