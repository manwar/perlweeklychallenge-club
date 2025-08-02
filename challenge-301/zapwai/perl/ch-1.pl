use v5.38;
sub proc(@ints) {
    say "Input: \@ints = @ints";
    say "Output: ", reverse sort @ints;
}
my @ints = (20, 3);
proc(@ints);
@ints = (3, 30, 34, 5, 9);
proc(@ints);