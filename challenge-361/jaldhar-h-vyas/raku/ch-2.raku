#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @party = @args.map({ $_.comb });
    my $celebrity = -1;

    for @party.keys -> $row {
        if all(@party[$row]) == 0 {
            if @party[*;$row].grep(0) == 1 {
                $celebrity = $row;
                last;
            }
        }
    }

    say $celebrity;
}
