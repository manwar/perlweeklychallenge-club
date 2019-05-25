use v6;

my @squares = map {$_ ** 2}, 100..*;   # lazy infinite list of squares
for @squares -> $square {
    if $square.comb.unique >= 5 {
        say $square;
        last;
    }
}
