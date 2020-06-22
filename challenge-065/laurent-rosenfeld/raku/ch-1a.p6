use v6;
sub MAIN (Int $nb_digits, Int $sum) {
    for 10 ** ($nb_digits - 1) .. 10 ** $nb_digits - 1 -> $num {
        say $num if $num.comb.sum == $sum;
    }
}
