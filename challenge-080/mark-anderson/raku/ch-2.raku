unit sub MAIN(*@ints where .all ~~ Int);

my $candies = @ints.elems;

@ints.push(Inf);
@ints.unshift(Inf);

for (1..^@ints.end) -> $i {
    $candies++ if @ints[$i] > @ints[$i-1];
    $candies++ if @ints[$i] > @ints[$i+1];
}

say $candies;
