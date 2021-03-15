use v6;

my @test = @*ARGS.elems > 0 ?? @*ARGS !! < tops opt bat pots saw tab pot top stop opts was x>;

my %words;
for @test -> $w {
    push %words, ([~] $w.comb.sort), $w;
}
for keys %words -> $k {
    say '[' ~ "%words{$k}" ~ ']';
}
