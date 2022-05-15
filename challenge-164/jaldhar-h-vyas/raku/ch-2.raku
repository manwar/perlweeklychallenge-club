#!/usr/bin/raku

sub isHappy(Int $i) {
    my $tries = 0;
    my $s = $i;

    while $s != 1 {
        if $tries == 8 {
            return False;
        }
        $s = $s.comb.map({ $_ ** 2 }).sum;
        $tries++;
    }

    return True;
}

sub MAIN() {
    my @happy;
    my $i = 1;

    while @happy.elems < 8 {
        if isHappy($i) {
            @happy.push($i);
        }
        $i++;
    }

    @happy.join(q{ }).say;
}