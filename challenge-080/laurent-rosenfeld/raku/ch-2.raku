use v6;

my @n = [1, 2, 2], [1, 4, 3, 2], [<3 1 5 8 7 4 2>];;
for  @n -> @nums {
    my $count = @nums.elems;
    for 0..@nums.end -> $i {
        $count++ if defined @nums[$i+$_] and
            @nums[$i] > @nums[$i+$_] for -1, 1;
    }
    say "Total candies required for [@nums[]]: $count.";
}
