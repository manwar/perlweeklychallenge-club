#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @q;
    @q.push({ coins => 0, box => @args });
    my $maxcoins = 0;

    while @q.elems {
        my  %node = @q.shift;
        my $coins = %node<coins>;
        my @box = %node<box>.List;

        if @box.elems == 0 {
            if $coins > $maxcoins {
                $maxcoins = $coins;
            }
            next;
        }

        for @box.keys -> $i {
            my $nextcoins = $coins + [*] (
                $i == 0 ?? 1 !! @box[$i - 1],
                @box[$i],
                $i == @box.end ?? 1 !! @box[$i + 1]
            );
            my @nextbox = @box;
            @nextbox.splice($i, 1);
            @q.push({ coins => $nextcoins, box => @nextbox });
        }
    }

    say $maxcoins;
}
