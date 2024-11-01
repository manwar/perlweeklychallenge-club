#!/usr/bin/raku

sub clear($row) {
    my $newRow = $row;
    while $newRow ~~ s:g/(.)$0$0+// {
    }

    return $newRow;
}

sub search($row, %handCount) {
    if $row eq q{} {
        return 0;
    }

    my $minInserts = ∞;

    for  0 .. $row.chars -> $i {
        for %handCount.keys -> $color {
            if %handCount{$color} < 1 {
                next;
            }

            %handCount{$color}--;
            my $newRow =
                clear($row.substr(0, $i) ~ $color ~ $row.substr($i));
            $minInserts = ($minInserts, 1 + search($newRow, %handCount)).min;
            %handCount{$color}++;
        }
    }

    return $minInserts;
}

sub MAIN(
    $row, $hand
) {
    my %handCount;

    for $hand.comb -> $ball {
        %handCount{$ball}++ ;
    }

    my $result = search($row, %handCount);

    say $result == ∞ ?? -1 !! $result;
}