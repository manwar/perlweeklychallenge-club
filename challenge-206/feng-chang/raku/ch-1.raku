#!/bin/env raku

unit sub MAIN(*@T);

my $today = now.Date;
my $tomorrow = $today.later(days => 1);

my @instants = @T.map({ "{$today.yyyy-mm-dd}T{$_}:00".DateTime });
@instants.push($_) for @T.map({ "{$tomorrow.yyyy-mm-dd}T{$_}:00".DateTime });
@instants .= sort;

put (^(+@instants-1)).map({ (@instants[$_+1] - @instants[$_]) / 60 }).min;
