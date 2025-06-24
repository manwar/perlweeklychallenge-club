use v5.38;

sub proc(@ints) {
    say "Input: @ints";
    my @o = grep {!($_ ~~ @ints)} (1 .. @ints);
    say "Output: @o";
}

my @ints = (1,2,1,3,2,5);
proc(@ints);
@ints = (1,1,1);
proc(@ints);
@ints = (2,2,1);
proc(@ints);
@ints = (2,1);
proc(@ints);
