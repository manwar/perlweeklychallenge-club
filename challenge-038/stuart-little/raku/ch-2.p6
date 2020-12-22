#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Str $dictionary-file,
) {

my %hash=(    
    1 => ('A' xx 8, 'G' xx 3, 'I' xx 5, 'S' xx 7, 'U' xx 5, 'X' xx 2, 'Z' xx 5).flat.Array,
    2 => ('E' xx 9, 'J' xx 3, 'L' xx 3, 'R' xx 3, 'V' xx 3, 'Y' xx 5).flat.Array,
    3 => ('F' xx 3, 'D' xx 3, 'P' xx 5, 'W' xx 5).flat.Array,
    4 => ('B' xx 5, 'N' xx 4).flat.Array,
    5 => ('T' xx 5, 'O' xx 3, 'H' xx 3, 'M' xx 4, 'C' xx 4).flat.Array,
    10 => ('K' xx 2, 'Q' xx 2).flat.Array,
);

my $freq=%hash.values.map(|*).sort.Bag;
my %pts=('A'..'Z').map({ $_ => %hash.keys.Array.grep( -> $key { %hash{$key}.any eq $_ }).[0] });

my @letters=$freq.roll(7);
say "Seven random letters from your bag: ",  @letters, "\n";

say $dictionary-file.IO.words.grep({ ! ($_.uc.comb.Bag (-) @letters) }).map({ $_, score($_,%pts) }).classify(*.[1]).max(*.[0]);

}

sub score($word,%pts) {
    $word.uc.comb.map({ %pts{$_} }).sum
}
