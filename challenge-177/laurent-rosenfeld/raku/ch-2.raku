sub is-cyclops ($n) {
    my $length = $n.chars;
    return False if $length %% 2;
    my $mid = ($length - 1) /2;
    return False if substr($n, $mid, 1) != 0;
    return False if $n.comb[0..$mid-1] ~~ /0/;
    return False if $n.comb[$mid+1..$length-1] ~~ /0/;
    return True;
}

my $count = 0;
for |(100..999), |(10000..99999), |(1000000..9999999) -> $i {
    next unless $i eq $i.flip;
    next unless $i.is-prime;
    if is-cyclops $i {
        print "$i ";
        $count++;
        last if $count == 20;
    }
}
say "";
