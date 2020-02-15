use v6;

my $garbled = q:to/END_MSG/;
P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
END_MSG

my @AoA = map { my @a = split /\s+/, $_; @a }, split /<[\r\n]>+/, $garbled;
my @transposed;
for (0 .. @AoA.end) -> $i {
    @transposed[$_][$i] = @AoA[$i][$_] for 0.. (@AoA[$i]).elems -1;
}
my @msg = "";
for @transposed -> $line {
    my BagHash $counter;
    $counter{$_}++ for @$line;
    push @msg, grep { $counter{$_} > 1 }, keys $counter;
}
say join "", @msg;
