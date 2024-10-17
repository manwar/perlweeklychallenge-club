sub com ($n, $k) {
    # Binomial coefficient formula for: n choose k
    my $nr_of_com = ([*] ($n - $k + 1)..$n)/([*] 1..$k);
    return $nr_of_com;
}

sub poker-hands (){
    my %hands =
        "0. RF" => com(4, 1),  # Royal flush
        "1. SF" => com(10, 1) * com(4, 1) - com(4, 1),
                               # Straight flush
        "2. FK" => com(13, 1) * com(12, 1) * com(4, 1),
                               # Four of a kind
        "3. FH" => com(13, 1) * com(4, 3) * com(12, 1)
            * com(4, 2),       # Full house
        "4. Fl" => com(13, 5) * com(4, 1) - com(10, 1)
            * com(4, 1),       # Flush (excl. RF and SF)
        "5. St" => com(10, 1) * com(4, 1)**5 - com(10, 1)
            * com(4, 1),       # Straight (excl. RF and SF)
        "6. TK" => com(13, 1) * com(4, 3) * com(12, 2)
            * com(4, 1) ** 2,  # Three of a kind
        "7. TP" => com(13, 2) * com(4, 2)**2 *com(11, 1)
            * com(4, 1),       # Two pairs
        "8. OP" => com(13, 1) * com(4, 2) * com(12, 3)
            * com(4, 1)**3,    # One pair
        "9. NP" => (com(13, 5) - com(10,1)) * (com(4, 1)**5
            - com(4, 1)),      # No pair (or High card)
    ;
    return %hands;
}

my %hand-count = poker-hands;
my $num-hands = com 52, 5;
say "Total number of hands (direct count) => $num-hands";

for %hand-count.keys.sort -> $key {
    say "  - $key => ", %hand-count{$key};
}
say "Sum of the hands by type => ", [+] %hand-count.values;
