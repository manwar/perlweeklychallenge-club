#! /usr/bin/raku

sub arraycomp(@a, @b) {
    if (@a.elems != @b.elems) {
        return False;
    }
    for @a.kv -> $i, $c {
        if (@b[$i] != $c) {
            return False;
        }
    }
    True;
}

my @deck;
for (0..3) -> $suit {
    for (1..13) -> $rank {
        @deck.push(($rank, $suit));
    }
}

my %hands;
for @deck.combinations(5) -> @hand {
    my $bin = 0;
    my @ranks = @hand.map({$_[0]}).sort({$^a <=> $^b});
    my %ranksc = @ranks.Bag;
    my @ranksk = %ranksc.values().sort({$^b <=> $^a});
    my @suits = @hand.map({$_[1]}).sort({$^a <=> $^b});
    my %suitsc = @suits.Bag;
    my @suitsk = %suitsc.values().sort({$^b <=> $^a});
    # Can't generate 5 of a kind.
    # Royal flush
    if (%suitsc.elems == 1 &&
                           arraycomp(@ranks, [1, 10, 11, 12, 13])) {
        $bin = 2;
    }
    # Straight flush
    if ($bin == 0 &&
                  %suitsc.elems == 1 &&
                                     @ranks.min + 4 == @ranks.max) {
        $bin = 2;
    }
    # Four of a kind
    if ($bin == 0 &&
                  @ranksk[0] == 4) {
        $bin = 3;
    }
    # Full house
    if ($bin == 0 &&
                  @ranksk[0] == 3 &&
                                  @ranksk[1] == 2) {
        $bin = 4;
    }
    # Flush
    if ($bin == 0 &&
                  @suitsk[0] == 5) {
        $bin = 5;
    }
    # Straight
    if ($bin == 0 &&
                  # match full rank struct
                  (
                      (@ranks[0] + 1 == @ranks[1] &&
                       @ranks[1] + 1 == @ranks[2] &&
                       @ranks[2] + 1 == @ranks[3] &&
                       @ranks[3] + 1 == @ranks[4])
                      ||
                      arraycomp(@ranks, [1, 10, 11, 12, 13])
                  )) {
        $bin = 6;
    }
    # Three of a kind
    if ($bin == 0 &&
                  @ranksk[0] == 3) {
        $bin = 7;
    }
    # Two pair
    if ($bin == 0 &&
                  @ranksk[0] == 2 && @ranksk[1] == 2) {
        $bin = 8;
    }
    # One pair
    if ($bin == 0 &&
                  @ranksk[0] == 2) {
        $bin = 9;
    }
    # Anything else is High card
    if ($bin == 0) {
        $bin = 10;
    }
    %hands{$bin}++;
}
my $tot = 0;
for %hands.keys.sort({$^a <=> $^b}) -> $k {
    say "$k " ~ %hands{$k};
    $tot += %hands{$k};
}
print "total $tot\n";
