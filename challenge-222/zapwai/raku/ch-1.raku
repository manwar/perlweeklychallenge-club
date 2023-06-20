my @ints1 = (1, 1, 4, 2, 1, 3);
my @ints2 = (5, 1, 2, 3, 4);
my @ints3 = (1, 2, 3, 4, 5);
for (@ints1, @ints2, @ints3) -> @ints {
    my @sorted = @ints.sort();
    say " Input: " ~ @ints;
    say "Sorted: " ~ @sorted;
    my @diff = @ints Z- @sorted;
    say "Output: " ~ (grep {$_ == 0}, @diff).elems;
}
