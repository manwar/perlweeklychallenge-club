sub check_multiples ($j) {
    my $ordered = join '', $j.comb.sort;
    for 2..6 -> $k {
        return False if ($k * $j).comb.sort.join ne $ordered;
    }
    return True;
}

.say and last if check_multiples $_ for 1..Inf;
