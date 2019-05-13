use v6;
.say for gather {
    for 1..50 -> $num {
        my $sum = [+] $num.comb;
        take $num if $num %% $sum
    }
}
