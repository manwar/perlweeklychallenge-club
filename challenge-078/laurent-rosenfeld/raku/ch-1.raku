use v6;

my @in = [9, 10, 7, 5, 6, 1], [3, 4, 5];
for @in -> @a {
    my @result = gather {
        my $max = @a[*-1];
        take $max;
        for @a.reverse -> $item {
            if $item > $max {
                take $item;
                $max = $item;
            }
        }
    }
    say "Input: @a[]; Output: ", @result.reverse;
}
