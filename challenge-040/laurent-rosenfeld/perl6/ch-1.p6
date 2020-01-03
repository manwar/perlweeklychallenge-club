use v6;

my @a = < I L O V E Y O U >,
        < 244 42 0 123344556677 222 0 11 >,
        < ! ?????? £ $ %% ^ & * >,
        < a b c d e f g f i j>;

my $max = max map { .elems }, @a;
my @max-lengths = map { .map({.chars}).max  }, @a;
my $fmt = [~] map {"%-" ~ @max-lengths[$_] + 2 ~ "s"}, keys @max-lengths;
say "Format: ", $fmt;  # Displaying the resulting formatting string
my @b;
for ^$max X ^@a.elems -> ($i, $j) {
    @b[$i][$j] = @a[$j][$i] // "";
}
printf "$fmt\n", @$_ for @b;
