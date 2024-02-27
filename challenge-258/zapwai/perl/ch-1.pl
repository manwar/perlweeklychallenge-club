use v5.36;

my @ints = (10, 1, 111, 24, 1000);
my @ints2 = (111, 1, 11111);
my @ints3 = (2, 8, 1024, 256);

proc(@ints);
proc(@ints2);
proc(@ints3);

sub proc (@ints) {
    say "Input: (@ints)";
    say "Output: ", cnt_even_lens(@ints);
}

sub cnt_even_lens(@ints) {
    my $cnt = 0;
    foreach my $item (@ints) {
	$cnt++ if (length($item) % 2 == 0);
    }
    return $cnt;
}
