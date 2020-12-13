#!/usr/bin/env raku

my $input = @*ARGS.head // 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';

say 'Input         : ' ~ $input;
say 'Length        : ' ~ $input.chars;
say 'Complementary : ' ~ $input.trans: 'TAGC' => 'ATCG';
