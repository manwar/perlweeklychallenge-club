#! /usr/bin/env raku

unit sub MAIN ($dominoes, :s(:$six), :v(:$verbose));

subset DOMINOES6 where { /^ <[0 .. 6]> ** 2 $/ };
subset DOMINOES9 where { /^ <[0 .. 9]> ** 2 $/ };

say ": Legal values: 0 .. { $six ?? "6" !! "9" }" if $verbose;

my @dominoes = $dominoes.words.map({ $_ > $_.flip ?? $_.flip !! $_});

say ": Dominoes (normalised): @dominoes[]" if $verbose;

die "Illegal value(s) in the input; digits 0-{ $six ?? "6" !! "9" } only" unless all(@dominoes) ~~ ( $six ?? DOMINOES6 !! DOMINOES9 );

my $bag = @dominoes.Bag.grep( *.value > 1);

say ": Bag (of duplicates): { $bag.raku }" if $verbose;

say $bag>>.value.sum;
