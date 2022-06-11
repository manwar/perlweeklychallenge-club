sub largest ($base) {
    my $largest_num = $base ** $base - 1;
    my $largest_root = $largest_num.sqrt.Int;
    for (1..$largest_root).reverse -> $i {
        my $sq = $i².base($base);
        next if $sq.chars != $sq.comb.Set;
        say "f($base) = $sq" and last;
    }
}
for 1..14 -> $test { largest $test }
