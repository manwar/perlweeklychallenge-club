# Make it $200
#
# You have only $1 left at the start of the week. You have been given an
# opportunity to make it $200. The rule is simple with every move you can
# either double what you have or add another $1. Write a script to help you get
# $200 with the smallest number of moves.

use experimental :cached;

sub best-strategy($cur-val, $target=200) is cached {
    if ($cur-val == $target) {
        return 0, [];
    }
    if ($cur-val > $target) {
        return -1, [];
    }

    my ($d1, $strat1) = best-strategy(2 * $cur-val, $target);
    my ($d2, $strat2) = best-strategy($cur-val + 1, $target);

    if ($d1 < 0 and $d2 < 0) {
        return -1, [];
    }
    if ($d1 < 0) {
        return $d2 + 1, (|($strat2), 2);
    }
    if ($d2 < 0) {
        return $d1 + 1, (|($strat1), 1);
    }
    if ($d1 < $d2) {
        return $d1 + 1, (|($strat1), 1);
    }
    else {
        return $d2 + 1, (|($strat2), 2);
    }
}

sub print-strategy($target) {
    my ($a, $b) = best-strategy(1, $target);
    say "In $a moves we can get $target dollar:";
    my $r = '';
    for $b.list -> $s {
        if ($s == 1) {
            $r ~= "2*(";
        } else {
            $r ~= "1+(";
        }
    }
    $r ~= '1' ~ (')' x $a);
    say $r ~ "=$target";
}


print-strategy(10);
print-strategy(200);
print-strategy(4200);
print-strategy(12345);
