use v6;

my @a = < I L O V E Y O U >,
        < 244 42 0 1233 222 0 11 >,
        < ! ???? £ $ %% ^ & * >,
        < a b c d e f g f i j>;

my $max = max map { .elems }, @a;
my @b;
for ^$max X ^@a.elems -> ($i, $j) {
    @b[$i][$j] = @a[$j][$i] // "";
}
say join "\t", @$_ for @b;
