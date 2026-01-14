#!/bin/env raku

unit sub MAIN(Str:D $results where $results.chars == 6 && $results.comb.all eq <H A>.any);

my @results = $results.comb;
my @winners;

@winners[0;0] = [2, 7][+(@results[0] eq 'A')];
@winners[0;1] = [3, 6][+(@results[1] eq 'A')];
@winners[0;2] = [4, 5][+(@results[2] eq 'A')];
@winners[0] .= sort;

@winners[1;0] = [1, @winners[0;2]][+(@results[3] eq 'A')];
@winners[1;1] = @winners[0][+(@results[4] eq 'A')];
@winners[1] .= sort;

@winners[2] = @winners[1];
@winners[2] .= reverse if @results[5] eq 'A';

put "Team {@winners[2;0]} defeated Team {@winners[2;1]}";
