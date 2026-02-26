use Lingua::EN::Numbers;

sub spellbound-sort(@input --> Seq) {
    return @input.sort({
        cardinal($_)
    });
}

my @tc_input = (
    [6, 7, 8, 9, 10],
    [-3, 0, 1000, 99],
    [1, 2, 3, 4, 5],
    [0, -1, -2, -3, -4],
    [100, 101, 102]
);

my @tc_output = (
    [8, 9, 7, 6, 10],
    [-3, 99, 1000, 0],
    [5, 4, 1, 3, 2],
    [-4, -1, -3, -2, 0],
    [100, 101, 102]
);

for @tc_input Z @tc_output -> (@tci, @tco) {
    my @output = spellbound-sort(@tci).Array;
    die "Test failed for @tci" unless @output eq @tco;
    say @output;
}
