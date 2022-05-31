my $max = 10;
my $count = 0;
for 101, 103  ...*  -> $n {
    next unless $n.is-prime;
    next unless rotate-and-test $n;
    print "$n ";
    $count++;
    last if $count >= $max;
}

sub rotate-and-test ($i is copy) {
    my $nb = $i.chars - 1;
    for 0..^$nb {
        $i = substr($i, 1) ~ substr($i, 0, 1);
        return False unless $i.is-prime;
    }
    return True;
}
